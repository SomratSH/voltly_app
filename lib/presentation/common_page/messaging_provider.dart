import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/application/message/model/chat_history_model.dart';
import 'package:voltly_app/application/message/model/chat_host_model.dart';
import 'package:voltly_app/application/message/model/chat_list_model.dart';
import 'package:voltly_app/application/message/repo/message_repo.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessagingProvider extends ChangeNotifier {
  ChatListModel _chats = ChatListModel();
  HostChatModel _chatsHost = HostChatModel();
  bool _isLoading = false;
  ChatHistoryModel chatHistoryModel = ChatHistoryModel();

  ChatListModel get chats => _chats;
  HostChatModel get hostChat => _chatsHost;
  bool get isLoading => _isLoading;

  WebSocketChannel? _channel;
  bool _isConnected = false;
  int? _chatId;
  int? localId;
  int? _userId;
  final List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => _messages;
  bool get isConnected => _isConnected;
  int? get userId => _userId;

  Future<void> getChatListMessage() async {
    final response = await MessageRepo().fetchChatsList();
    _chats = response;
    notifyListeners();
  }

  Future<void> getChatListHost() async {
    final response = await MessageRepo().fetchHostChatsList();
    _chatsHost = response;
    notifyListeners();
  }

  /// Connect WebSocket + Load Previous Messages
  Future<void> connect(int chatId) async {
    _chatId = chatId;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      localId = prefs.getInt("id");

      await _loadPreviousMessages(chatId);
      if (token == null || token.isEmpty) {
        debugPrint("⚠️ No token found in SharedPreferences");
        return;
      }

      final url = "ws://10.10.13.20:8005/ws/chat/$chatId/?token=$token";
      debugPrint("🔌 Connecting to WebSocket: $url");

      _channel = WebSocketChannel.connect(Uri.parse(url));
      _isConnected = true;
      notifyListeners();

      // ✅ Load chat history immediately after connection

      // ✅ Listen to new real-time messages
      _channel!.stream.listen(
        (event) {
          debugPrint("📩 WebSocket Event: $event");
          try {
            final data = jsonDecode(event);

            // User ID info
            if (data["type"] == "user.status" && data["user_id"] != null) {
              _userId = data["user_id"];
              debugPrint("✅ User ID from WebSocket: $_userId");
              notifyListeners();
              return;
            }

            // Normal chat message
            if (data["message"] != null || data["text"] != null) {
              _addMessage(data);
            }
          } catch (e) {
            debugPrint("❌ Error decoding message: $e");
          }
        },
        onError: (error) {
          debugPrint("❌ WebSocket error: $error");
          _isConnected = false;
          notifyListeners();
        },
        onDone: () {
          debugPrint("🔒 WebSocket closed");
          _isConnected = false;
          notifyListeners();
        },
      );
    } catch (e) {
      debugPrint("❌ WebSocket connection failed: $e");
      _isConnected = false;
      notifyListeners();
    }
  }

  /// Helper: Load and merge chat history
  Future<void> _loadPreviousMessages(int roomId) async {
    try {
      final response = await MessageRepo().getChatHistory(roomId);
      chatHistoryModel = response;

      // Convert history model to list of map
      final oldMessages = (chatHistoryModel.messages ?? [])
          .map(
            (msg) => {
              "id": msg.id,
              "message": msg.text,
              "sender_id": msg.sender?.id,
              "timestamp": msg.timestamp,
            },
          )
          .toList();

      _messages
        ..clear()
        ..addAll(oldMessages); // ✅ Add old messages first

      debugPrint("🕓 Loaded ${oldMessages.length} previous messages");
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Failed to load chat history: $e");
    }
  }

  /// Helper: Avoid duplicate messages
  void _addMessage(Map<String, dynamic> data) {
    final exists = _messages.any((m) => m["id"] == data["id"]);
    if (!exists) {
      _messages.add(data);
      notifyListeners();
    }
  }

  void sendMessage(String text) {
    if (!_isConnected || _channel == null) {
      debugPrint("⚠️ Cannot send — not connected");
      return;
    }
    final message = {"message": text, "sender_id": localId};
    debugPrint("📤 Sending message: $message");
    _channel!.sink.add(jsonEncode(message));

    // Add locally for immediate UI update
    _messages.add({
      "id": DateTime.now().millisecondsSinceEpoch, // temporary ID
      "message": text,
      "sender_id": localId,
      "timestamp": DateTime.now().toIso8601String(),
    });
    notifyListeners();
  }

  void disconnect() {
    if (_isConnected) {
      debugPrint("🔌 Closing WebSocket connection...");
      _channel?.sink.close();
      _isConnected = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
