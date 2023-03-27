import 'package:ditto/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/strings.dart';

class KeyField extends StatefulWidget {
  const KeyField({
    super.key,
  });

  @override
  State<KeyField> createState() => _KeyFieldState();
}

class _KeyFieldState extends State<KeyField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.yourPrivateKey,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
              ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: AppStrings.writeYourKey,
            suffixIcon: GestureDetector(
              onTap: () {
                Clipboard.getData('text/plain').then(
                  (value) {
                    if (value != null && value.text != null) {
                      _controller!.text = value.text!;
                    }
                  },
                );
              },
              child: Icon(
                FlutterRemix.clipboard_line,
                color: AppColors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
