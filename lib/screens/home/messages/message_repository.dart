import 'dart:convert';
import 'dart:math';

import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/model/complaint_model.dart';
import 'package:chatbot/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/errors.dart';

@immutable
abstract class MessageRepository {
  /// All subfunctions are final No arguments required returns json
  Future<List<MessageModel>> getAllMessages();
}

class APIMessageRepository extends MessageRepository {
  final String classTag = "APIMessageRepository";
  
  Future<List<MessageModel>> getAllMessages() async {
    final List<MessageModel> messageList = List.empty(growable: true);
    final db = FirebaseFirestore.instance;

    try {
      await db.collection("messages").get().then((value) {
        value.docs.forEach((element) {
          try {
            print(element.data());

            
                messageList.add(MessageModel.fromFirestore(element));

                        
              

       
            
          } on StateError catch (e) {
            print("state error");
          }
        });
      });
      return messageList;
    } on FirebaseException catch (e) {
      print(e);
      throw UnknownException();
    } catch (error) {
      print(error);
      throw UnknownException();
    }
  }
  
 
  
  
  
 
}
