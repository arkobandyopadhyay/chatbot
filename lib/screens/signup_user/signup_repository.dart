import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../core/utils/errors.dart';

abstract class SignupRepository {
  Future<void> signup(String email, String password, String room);
}

class APISignupRepository implements SignupRepository {
  final String classTag = "APILoginRepository";
  @override
  Future<void> signup(String email, String password, String room) async {
    http.Response? response;
    try {
      final Uri url = Uri.parse(
          "https://tech-server-chatbot1.onrender.com/auth/signup/user");

      response = await http.post(url, headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      }, body: {
        "email": email,
        "password": password,
        "room": room,
      });
      print("response:" + response.body);
    } catch (e) {
      print("hi");
      print(e);
    }

    if (response!.statusCode == 200) {
      try {
        String? token = json.decode(response.body)['_id'];
        return;
      } catch (e) {
        print(e);
      }
    } else if (response.statusCode == 400) {
      throw ValidationException(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw ResponseException(jsonDecode(response.body)['detail']);
    } else {
      throw UnknownException();
    }
  }
}
