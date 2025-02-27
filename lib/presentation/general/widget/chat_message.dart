import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.text,
    required this.sender,
  });

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 13),
          child: Container(
            height: 38,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: sender == 'user' ? Colors.blue[200] : Colors.red[50],
            ),
            child: Center(
              child: Text(
                sender,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sender == 'user' ? 14 : 30,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SelectableText(text),
        ),
      ],
    );
  }
}
