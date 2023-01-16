import 'package:chatbot/screens/admin_login/SignInScreen.dart';
import 'package:chatbot/screens/admin_login/cubit/admin_login_cubit.dart';
import 'package:chatbot/screens/admin_login/login_admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JarvisBot',
      theme: ThemeData(brightness: Brightness.dark),
      home: BlocProvider(
              create: (_) => LoginAdminCubit(APILoginAdminRepository()),
              child: SignInScreen()),
    );
  }
}
