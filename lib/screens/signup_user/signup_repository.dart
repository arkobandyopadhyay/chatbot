import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/errors.dart';
import '../../core/utils/shared.dart';

abstract class SignupRepository {
  //  final firebase_auth.FirebaseAuth _firebaseAuth;
  Future<void> signup(String email, String password, String room);
}

class APISignupRepository implements SignupRepository {
  final String classTag = "APILoginRepository";
  
  @override
  Future<void> signup(String email, String password, String room) async {

    UserCredential? response;
    try {
       response =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      UserSimplePreferences.setRoom(room);
      UserSimplePreferences.setEmail(email);
      UserSimplePreferences.setPass(password);
      UserSimplePreferences.setType("user");
      UserSimplePreferences.setId(json.decode(response.user!.uid.toString()));

      print("response:" + response.toString());
    } catch (e) {
      print("hi");
      print(e);
    }
    String id=response!.user!.uid.toString();

    if (response.user!.uid!=null) {
      try {
        final CollectionReference<Map<String, dynamic>> _collectionReference =
            FirebaseFirestore.instance.collection("users");
        
        await _collectionReference.doc(id).set({
          "email": email,
          "password": password,
          "room":room,

        });
        
        return;
      } catch (e) {
        print(e);
      }
    } 
    else {
      throw UnknownException();
    }
  }
  // Future<void> signup(String email, String password, String room) async {
  //   http.Response? response;
  //   try {
  //     final Uri url = Uri.parse(
  //         "https://tech-server-chatbot1.onrender.com/auth/signup/user");

  //     response = await http.post(url, headers: <String, String>{
  //       'Context-Type': 'application/json;charSet=UTF-8'
  //     }, body: {
  //       "email": email,
  //       "password": password,
  //       "room": room,
  //     });
  //     UserSimplePreferences.setRoom(room);
  //     UserSimplePreferences.setEmail(email);
  //     UserSimplePreferences.setPass(password);
  //     UserSimplePreferences.setType("user");
  //     UserSimplePreferences.setId(json.decode(response.body)['_id']);

  //     print("response:" + response.body);
  //   } catch (e) {
  //     print("hi");
  //     print(e);
  //   }

  //   if (response!.statusCode == 200) {
  //     try {
  //       String? token = json.decode(response.body)['_id'];
  //       print("token=$token");
  //       return;
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else if (response.statusCode == 400) {
  //     throw ValidationException(response.body);
  //   } else if (response.statusCode == 401 || response.statusCode == 404) {
  //     throw ResponseException(jsonDecode(response.body)['detail']);
  //   } else {
  //     throw UnknownException();
  //   }
  // }
}
