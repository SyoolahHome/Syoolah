import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:ditto/presentation/general/widget/chat_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../constants/colors.dart';
import 'widgets/text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _inputMessage = TextEditingController();
  List<ChatMessage> _messages = [];
  OpenAI? openAI;

  StreamSubscription? subscription;
  bool isTyping = false;

  @override
  void initState() {
    openAI = OpenAI.instance;
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

    final request = CompleteText(
      prompt: chatMessage.text,
      model: "text-",
      maxTokens: 200,
    );

    openAI!
        // .builder('write the path here from Open AI', orgId: '')
        .onCompletionStream(request: request)
        .listen((response) {
      ChatMessage botMessage =
          ChatMessage(text: response!.choices[0].text, sender: "🤖");

      setState(() {
        isTyping = false;
        try {
          if (kDebugMode) {
            print(response.choices[0].text);
          }
          _messages.insert(0, botMessage);
        } catch (e) {
          print('Failed');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Playground'),
        elevation: 0,
        backgroundColor: AppColors.teal,
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
                separatorBuilder: (context, index) => SizedBox(height: 17),
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
