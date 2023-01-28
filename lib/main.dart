import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/screens/admin_login/SignInScreen.dart';
import 'package:chatbot/screens/admin_login/cubit/admin_login_cubit.dart';
import 'package:chatbot/screens/admin_login/login_admin_repository.dart';
import 'package:chatbot/screens/splash/cubit/splash_cubit.dart';
import 'package:chatbot/screens/splash/splash_repository.dart';
import 'package:chatbot/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI ChatBot',
      theme: ThemeData(brightness: Brightness.dark),
      home: BlocProvider(
              create: (_) => SplashCubit(APISplashRepository()),
              child: SplashScreen()),
    );
  }
}
