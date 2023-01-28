import 'dart:async';
import 'package:chatbot/core/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../admin_login/SignInScreen.dart';
import '../admin_login/cubit/admin_login_cubit.dart';
import '../admin_login/login_admin_repository.dart';
import '../home/home.dart';
import '../login_user/SignInScreen2.dart';
import '../login_user/cubit/login_user_cubit.dart';
import '../login_user/login_user_repository.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    String? token = UserSimplePreferences.getEmail();
    // String? token=null;
     print(UserSimplePreferences.getEmail());
    if (token == null) {
      Future.delayed(Duration(milliseconds: 1000)).then(
          (value) =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BlocProvider(
              create: (_) => LoginAdminCubit(APILoginAdminRepository()),
              child: SignInScreen()))));
    } else {
      context.read<SplashCubit>().login();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<SplashCubit, SplashState>(
            listener: (context, state) {
              if (state is SplashError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Something went wrong. Try loging in again.")));
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BlocProvider(
              create: (_) => LoginUserCubit(APILoginRepository()),
              child: SignInScreen2()),));
              } else if (state is SplashSuccess) {
                Future.delayed(Duration(milliseconds: 500)).then(
                    (value) =>
                       Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return const Home();
            }))));
              }
            },
            builder: (context, state) {
              if (state is SplashSuccess || state is SplashLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Text("Check your internet connection and try again"),
                ); // TODO add retry widget
              }
            },
          ),
        ],
      ),
    );
  }
}
