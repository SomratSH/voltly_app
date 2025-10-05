import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/constant/app_colors.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Simple message model: isUser true for user's messages
  final List<_Message> _messages = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_Message(text: text, isUser: true));
      _controller.clear();
      _isLoading = true;
    });

    // allow UI to update and scroll to bottom
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollToBottom();

    // Simulate AI response (replace with real API call)
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _messages.add(
        _Message(
          text: "I heard you: '$text' — I'll help with that!",
          isUser: false,
        ),
      );
      _isLoading = false;
    });

    await Future.delayed(const Duration(milliseconds: 50));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onNotificationTap: () {
          debugPrint('Notification tapped!');
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // If there are no messages yet, show the friendly start screen
              if (_messages.isEmpty) ...[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 94,
                        height: 73,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.50, 0.10),
                            end: Alignment(0.50, 0.50),
                            colors: [primaryColor, Color(0xFF121C24)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(44)),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F01E601),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/image/ai_car.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Hello Boss! ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Am Ready for help you',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      vPad20,
                      const Text(
                        'Ask me anything what’s are on your mind . Am here to assist you!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Conversation view
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return Align(
                        alignment: msg.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: msg.isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              decoration: msg.isUser
                                  ? ShapeDecoration(
                                      color: const Color(0xFFDFE8F6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                    )
                                  : ShapeDecoration(
                                      color: const Color(0xFF007F5F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                    ),
                              child: Column(
                                children: [
                                  Text(
                                    msg.text,
                                    style: msg.isUser
                                        ? TextStyle(
                                            color: const Color(0xFF424F7B),
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            height: 1.83,
                                            letterSpacing: 0.12,
                                          )
                                        : TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            height: 1.83,
                                            letterSpacing: 0.12,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: msg.isUser
                                  ? const EdgeInsets.only(right: 10.0)
                                  : const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '12:23pm',
                                style: TextStyle(
                                  color: const Color(0xFFA9B4CD),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 1.83,
                                  letterSpacing: 0.12,
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

              // Input area (visible always so user can start typing)
              Container(
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type message here',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.83,
                            letterSpacing: 0.12,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                    _isLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            onPressed: _send,
                            icon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                color: Color(0xff007F5F),
                                'assets/icon/send-2.svg',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              vPad20,
            ],
          ),
        ),
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isUser;
  _Message({required this.text, required this.isUser});
}
