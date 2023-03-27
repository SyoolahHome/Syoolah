import 'package:ditto/scan.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:ditto/model/profile.dart';
import 'package:ditto/screen/home.dart';

import 'BottomBar.dart';

final logger = Logger();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MProfile(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: SizedBox(
              height: 180,
              width: 180,
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
          ),
          Text(
            "Hajji",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80, top: 16),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 15,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  hintText: "What's your name?"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.tealAccent),
            padding: EdgeInsets.all(10),
            child: InkWell(
              child: const Text(
                "Go",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const BottomBar()));
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          InkWell(
            child: const Text("Private Key access"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ScanKey()));
            },
          )
        ],
      )),
    );
  }
}
