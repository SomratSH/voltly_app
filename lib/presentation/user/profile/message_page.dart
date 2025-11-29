import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/commone_helper.dart';
import 'package:voltly_app/common/custom_html_text.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/common_page/messaging_provider.dart';
import 'package:voltly_app/presentation/user/profile/converstation_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MessagingProvider>()..getChatListMessage();
    return Scaffold(
      // dark background
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Voltly", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Message",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // 🔍 Search Bar
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search for message here",
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 📩 Messages List
            Expanded(
              child: ListView.builder(
                itemCount: provider.chats.chats!.length,
                itemBuilder: (context, index) {
                  final msg = provider.chats.chats![index];
                  return ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          chatId: msg.chatRoomId!,
                          name: msg.host!.name!,
                          picture: msg.host!.profileImage!,
                        ),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: msg.host!.profileImage == null
                          ? NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/3675/3675805.png",
                            )
                          : NetworkImage(
                              "${AppUrls.imageUrl}${msg.host!.profileImage.toString()}",
                            ),
                      radius: 24,
                    ),
                    title: Text(
                      msg.host!.name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      msg.lastMessage ?? "N/A",
                      style: const TextStyle(color: Colors.white70),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          msg.lastMessageTime == null
                              ? ""
                              : convertToAmPm(msg.lastMessageTime!),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // if (msg["unread"] > 0)
                        //   CircleAvatar(
                        //     radius: 10,
                        //     backgroundColor: Colors.green,
                        //     child: Text(
                        //       msg["unread"].toString(),
                        //       style: const TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String convertToAmPm(String timestamp) {
  try {
    final dt = DateTime.parse(timestamp);
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  } catch (e) {
    return "";
  }
}
