
import 'package:flutter/material.dart';

class GlobalChatRelays extends StatefulWidget {
  const GlobalChatRelays({Key? key}) : super(key: key);

  @override
  _GlobalChatRelaysState createState() => _GlobalChatRelaysState();
}

class _GlobalChatRelaysState extends State<GlobalChatRelays> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global Messages"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        leading: InkWell(
          child: const Icon(
              Icons.arrow_back),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: Text("Loading.....")),
            )
          ],
        ),
      ),
    );
  }
}
