import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'package:voltly_app/constant/app_urls.dart';

class AiChatProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<Message> messages = [];
  bool isLoading = false;

  String baseUrl = AppUrls.baseUrl;

  /// Send user message to AI backend
  Future<void> send() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final text = controller.text.trim();
    if (text.isEmpty) return;

    // Add user message instantly
    messages.add(Message(text: text, isUser: true, time: DateTime.now()));
    controller.clear();
    notifyListeners();
    _scrollToBottom();

    // Show loading
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/chat/ai-chat/?latitude=25.7616898&longitude=-80.1917902',
        ),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${preferences.getString("authToken")}",
        },
        body: jsonEncode({"text": text}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);

        // Take 2nd index (AI response)
        if (data.length > 1 && data[1]['text'] != null) {
          final aiText = data[1]['text'] as String;
          await _showTypingEffect(aiText);
        }
      } else {
        messages.add(Message(
          text: "⚠️ Error: Unable to get response (Code ${response.statusCode})",
          isUser: false,
          time: DateTime.now(),
        ));
        notifyListeners();
      }
    } catch (e) {
      messages.add(Message(
        text: "⚠️ Error: $e",
        isUser: false,
        time: DateTime.now(),
      ));
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
    _scrollToBottom();
  }

  /// Show AI response character by character
  Future<void> _showTypingEffect(String fullText) async {
    String displayedText = "";
    messages.add(Message(text: "", isUser: false, time: DateTime.now()));
    notifyListeners();

    for (int i = 0; i < fullText.length; i++) {
      displayedText += fullText[i];
      messages[messages.length - 1] =
          Message(text: displayedText, isUser: false, time: DateTime.now());
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 20));
      _scrollToBottom();
    }
  }

  /// Scroll chat to bottom
  void _scrollToBottom() {
    if (!scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

/// Chat message model
class Message {
  final String text;
  final bool isUser;
  final DateTime time;

  Message({required this.text, required this.isUser, required this.time});

  /// Returns 12-hour formatted time (e.g., 11:56 PM)
  String get formattedTime => DateFormat('h:mm a').format(time);
}
