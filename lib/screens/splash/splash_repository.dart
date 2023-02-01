import 'dart:convert';
import 'dart:math';
// import 'package:ecellapp/core/res/errors.dart';
// import 'package:ecellapp/core/res/strings.dart';
// import 'package:ecellapp/core/utils/injection.dart';
// import 'package:ecellapp/core/utils/logger.dart';
import 'package:chatbot/core/utils/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/errors.dart';

abstract class SplashRepository {
  /// Takes in login credentials (here id and password)
  /// Use by implementing this class
  Future<void> login();
}

class APISplashRepository implements SplashRepository {
  @override
  Future<void> login() async {
    UserCredential response;
    try {


       response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: UserSimplePreferences.getEmail()!,
        password: UserSimplePreferences.getPass()!,
      );
      String? id=response.user?.uid.toString();
      final Future<DocumentSnapshot<Map<String, dynamic>>> snap=FirebaseFirestore.instance.collection("users").doc(id).get();
      print(snap.then((value){
        UserSimplePreferences.setEmail(value.get('email'));
      UserSimplePreferences.setPass(value.get('password'));
      UserSimplePreferences.setRoom(value.get('room'));
      UserSimplePreferences.setId(id!);

      } ));


      print("response:" + response.toString());
      print("uid:${response.user!.uid.toString()}");
      
      
    } catch (e) {
      print("hi");
      print(e);
    }
  }
}
