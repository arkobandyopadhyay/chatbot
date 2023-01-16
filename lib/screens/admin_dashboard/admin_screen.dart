import 'package:chatbot/screens/admin_login/SignInScreen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return SignInScreen();
                  },
                ));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text('App Under construction'),
      ),
    );
  }
}
