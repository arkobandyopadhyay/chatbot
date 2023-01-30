import 'dart:convert';
import 'dart:math';

import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/model/complaint_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/errors.dart';

@immutable
abstract class DrawerRepository {
  /// All subfunctions are final No arguments required returns json
  Future<List<Item>> getAllComplaints();
}

class APIDrawerRepository extends DrawerRepository {
  final String classTag = "APIDrawerRepository";
  
  @override
  Future<List<Item>> getAllComplaints() async {
    final List<Item> complaintList = List.empty(growable: true);
    final db = FirebaseFirestore.instance;

    try {
      await db.collection("complaints").get().then((value) {
        value.docs.forEach((element) {
          try {
            print(element.data());

              if(element.data()['room']==UserSimplePreferences.getRoom()){
                complaintList.add(Item.fromFirestore(element));

              }            
              

       
            
          } on StateError catch (e) {
            print("state error");
          }
        });
      });
      return complaintList;
    } on FirebaseException catch (e) {
      print(e);
      throw UnknownException();
    } catch (error) {
      print(error);
      throw UnknownException();
    }
  }
}
