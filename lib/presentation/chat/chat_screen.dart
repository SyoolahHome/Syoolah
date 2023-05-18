import 'dart:async';

import 'package:ditto/presentation/chat/widgets/text_field.dart';
import 'package:ditto/presentation/general/widget/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _inputMessage = TextEditingController();
  final List<ChatMessage> _messages = [];

  StreamSubscription? subscription;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  void sendMessage() {
    ChatMessage chatMessage =
        ChatMessage(text: _inputMessage.text, sender: "user");

    setState(() {
      _messages.insert(0, chatMessage);
      isTyping = true;
    });
    _inputMessage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Playground'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
              child: ListView.separated(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 17),
              ),
            ),
          ),
          if (isTyping)
            JumpingDotsProgressIndicator(
              fontSize: 48.0,
            ),
          CustomTextField(
            controller: _inputMessage,
            onSubmit: sendMessage,
          ),
        ],
      ),
    );
  }
}
