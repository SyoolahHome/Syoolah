import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final void Function() onSubmit;
  @override
  Widget build(BuildContext context) {
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
                controller: controller,
                onSubmitted: (value) => onSubmit(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintStyle: const TextStyle(fontSize: 14),
                  hintText: "Type anything",
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  contentPadding: const EdgeInsets.only(left: 20),
                ),
              ),
            ),
            IconButton(
              onPressed: () => onSubmit(),
              icon: const Icon(Icons.send_rounded, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
