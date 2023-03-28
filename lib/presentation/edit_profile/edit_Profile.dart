import 'package:flutter/material.dart';
import '../bottom_bar_screen/Bottom_bar_screen.dart';
import 'widgets/edit_field.dart';
import 'widgets/save_button.dart';
import 'widgets/top_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              TopBar(),
              SizedBox(height: 20),
              EditField(label: "Name:"),
              EditField(label: "Username:"),
              EditField(label: "Picture url:"),
              EditField(label: "about:"),
              EditField(label: "Banner url:"),
              EditField(label: "Bitcoin lightning address:"),
              EditField(label: "Nostr address(nip05):"),
              SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
