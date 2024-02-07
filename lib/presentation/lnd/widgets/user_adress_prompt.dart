import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:flutter/material.dart';

class UserAddressPromptWidget extends StatelessWidget {
  const UserAddressPromptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextField(),
        UmrahtyButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          text: "Submit",
        ),
      ],
    );
  }
}
