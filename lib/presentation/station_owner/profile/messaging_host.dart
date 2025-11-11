import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/commone_helper.dart';
import 'package:voltly_app/common/custom_html_text.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/common_page/messaging_provider.dart';
import 'package:voltly_app/presentation/station_owner/profile/conversation_host.dart';
import 'package:voltly_app/presentation/user/profile/converstation_screen.dart';

class MessagingHost extends StatelessWidget {
  const MessagingHost({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MessagingProvider>();
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
                itemCount: provider.hostChat.chats!.length,
                itemBuilder: (context, index) {
                  final msg = provider.hostChat.chats![index];
                  return ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConversationHost(
                          chatId: msg.chatRoomId!,
                          name: msg.driver!.name!,
                          picture: msg.driver!.profileImage!,
                        ),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: msg.driver!.profileImage == null
                          ? NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/3675/3675805.png",
                            )
                          : NetworkImage(
                              "${AppUrls.imageUrl}${msg.driver!.profileImage.toString()}",
                            ),
                      radius: 24,
                    ),
                    title: Text(
                      msg.driver!.name!,
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
                              : msg.lastMessageTime!,
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
