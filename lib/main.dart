import 'package:ditto/scan.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:ditto/model/profile.dart';
import 'BottomBar.dart';
import 'constants/strings.dart';
import 'constants/themes.dart';
import 'presentation/home/home.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.primary,
      home: const MyHomePage(),
    );
  }
}
