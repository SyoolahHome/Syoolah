import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:ditto/presentation/general/widget/chat_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:progress_indicators/progress_indicators.dart';

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
        title: Text('Chatbot Playground'),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 55, 201, 165),
      ),
      body: Column(children: [
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
        customTextFieldWIdget(),
      ]),
    );
  }

  Padding customTextFieldWIdget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                controller: _inputMessage,
                onSubmitted: (value) => sendMessage(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: "Type anything",
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  contentPadding: EdgeInsets.only(left: 20),
                ),
              ),
            ),
            IconButton(
              onPressed: () => sendMessage(),
              icon: Icon(Icons.send_rounded, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
