import 'package:chatbot/SignInScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JarvisBot',
      theme: ThemeData(brightness: Brightness.dark),
      home: SignInScreen(),
    );
  }
}
