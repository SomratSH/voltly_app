import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/common_page/messaging_provider.dart';

class ConversationHost extends StatelessWidget {
  final int chatId; // dynamic chat room id
  final TextEditingController _controller = TextEditingController();
  final String name;
  final String picture;

  ConversationHost({
    super.key,
    required this.chatId,
    required this.name,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          MessagingProvider()
            ..connect(chatId), // Connect WebSocket + load old messages
      builder: (context, _) {
        final chatProvider = context.watch<MessagingProvider>();

        return Scaffold(
          appBar: AppBar(
            title: Text("Voltly", style: const TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              _buildProfileHeader(),

              // Loader while connecting
              if (!chatProvider.isConnected)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.greenAccent),
                  ),
                )
              else
                // Message List
                Expanded(
                  child: chatProvider.messages.isEmpty
                      ? const Center(
                          child: Text(
                            'No messages yet',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: chatProvider.messages.length,
                          itemBuilder: (context, index) {
                            final msg = chatProvider.messages.reversed
                                .toList()[index];
                            final isMe =
                                msg['sender_id'] == chatProvider.localId;

                            return Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? const Color(0xFFDFE8F6)
                                          : const Color(0xFF01CC01),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      // ✅ support both previous (message) & new (text)
                                      msg['message'] ?? msg['text'] ?? '',
                                      style: TextStyle(
                                        color: isMe
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  if (msg['timestamp'] != null)
                                    Text(
                                      formatTo12HourTime(msg['timestamp']),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                ),

              // Message input bar
              _buildMessageInput(context, chatProvider),
            ],
          ),
        );
      },
    );
  }

  // 👤 Profile Header
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${AppUrls.imageUrl}$picture"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Last online 11 minutes ago',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 💬 Message Input Field
  Widget _buildMessageInput(BuildContext context, MessagingProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF243026),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Type message here...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.greenAccent),
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  provider.sendMessage(text);
                  _controller.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ⏰ Format timestamp to 12-hour time
String formatTo12HourTime(String? timestamp) {
  if (timestamp == null || timestamp.isEmpty) return "";
  try {
    final dateTime = DateTime.parse(timestamp);
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  } catch (_) {
    return "";
  }
}
