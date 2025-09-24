import 'package:flutter/material.dart';
import 'package:voltly_app/presentation/user/profile/converstation_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        "name": "Fahmida Tasmin",
        "message": "Is this vehicle available for rent?",
        "time": "12:23pm",
        "unread": 2,
        "image": "https://randomuser.me/api/portraits/women/1.jpg",
      },
      {
        "name": "Niloy Islam",
        "message": "Is this vehicle available for rent?",
        "time": "12:23pm",
        "unread": 0,
        "image": "https://randomuser.me/api/portraits/men/2.jpg",
      },
      {
        "name": "Md Rifat",
        "message": "Is this vehicle available for rent?",
        "time": "12:23pm",
        "unread": 0,
        "image": "https://randomuser.me/api/portraits/men/3.jpg",
      },
      {
        "name": "Sahib Sarkar",
        "message": "Is this vehicle available for rent?",
        "time": "12:23pm",
        "unread": 0,
        "image": "https://randomuser.me/api/portraits/men/4.jpg",
      },
      {
        "name": "Shama Islam",
        "message": "Is this vehicle available for rent?",
        "time": "12:23pm",
        "unread": 0,
        "image": "https://randomuser.me/api/portraits/women/5.jpg",
      },
    ];

    return Scaffold(
      // dark background
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
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
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatPage()),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(msg["image"]),
                      radius: 24,
                    ),
                    title: Text(
                      msg["name"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      msg["message"],
                      style: const TextStyle(color: Colors.white70),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          msg["time"],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (msg["unread"] > 0)
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Text(
                              msg["unread"].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
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
