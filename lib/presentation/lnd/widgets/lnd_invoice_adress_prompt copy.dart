import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:flutter/material.dart';

class UserLndInvoicePromptWidget extends StatelessWidget {
  const UserLndInvoicePromptWidget({super.key, required this.onSubmit});

  final Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextField(),
        SakhirButton(
          onTap: () {
            onSubmit("test");
          },
          text: "Submit",
        ),
      ],
    );
  }
}
