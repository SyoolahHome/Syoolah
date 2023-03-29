import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:ditto/model/profile.dart';
import 'constants/strings.dart';
import 'constants/themes.dart';
import 'presentation/home/home.dart';

final logger = Logger();

Future<void> main() async {
  await LocalDatabase.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MProfile()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
        ],
        child: MaterialApp(
          routes: Routing.routes,
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.primary,
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
