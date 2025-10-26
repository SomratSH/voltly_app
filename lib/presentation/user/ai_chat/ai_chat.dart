import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_html_text.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'ai_chat_provider.dart';

class AiChat extends StatelessWidget {
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AiChatProvider(),
      child: _Layout(),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AiChatProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("Chat", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Empty State
              if (provider.messages.isEmpty) ...[
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
                            colors: [primaryColor, const Color(0xFF121C24)],
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
                        'Hello Boss!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Am Ready for help you',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      vPad20,
                      const Text(
                        'Ask me anything what’s on your mind. I’m here to assist you!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Chat Messages
                Expanded(
                  child: ListView.builder(
                    controller: provider.scrollController,
                    itemCount: provider.messages.length,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) {
                      final msg = provider.messages[index];
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
                              decoration: ShapeDecoration(
                                color: msg.isUser
                                    ? const Color(0xFFDFE8F6)
                                    : const Color(0xFF007F5F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(10),
                                    topRight: const Radius.circular(10),
                                    bottomLeft: msg.isUser
                                        ? const Radius.circular(10)
                                        : Radius.zero,
                                    bottomRight: msg.isUser
                                        ? Radius.zero
                                        : const Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text(
                                toPlainText(msg.text),
                                style: TextStyle(
                                  color: msg.isUser
                                      ? const Color(0xFF424F7B)
                                      : Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.83,
                                  letterSpacing: 0.12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: msg.isUser
                                  ? const EdgeInsets.only(right: 10.0)
                                  : const EdgeInsets.only(left: 10.0),
                              child: Text(
                                msg.formattedTime,
                                style: const TextStyle(
                                  color: Color(0xFFA9B4CD),
                                  fontSize: 12,
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

              // Input Area
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
                        controller: provider.controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type message here',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.83,
                            letterSpacing: 0.12,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onSubmitted: (_) =>
                            context.read<AiChatProvider>().send(),
                      ),
                    ),
                    provider.isLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            onPressed: () =>
                                context.read<AiChatProvider>().send(),
                            icon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                'assets/icon/send-2.svg',
                                color: const Color(0xff007F5F),
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
