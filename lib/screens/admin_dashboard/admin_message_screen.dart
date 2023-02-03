import 'dart:convert';

import 'package:chatbot/screens/widgets/custom_main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/shared.dart';

class AdminMessageScreen extends StatefulWidget {
  const AdminMessageScreen({super.key});
  @override
  State<AdminMessageScreen> createState() => _AdminMessageScreenState();
}

class _AdminMessageScreenState extends State<AdminMessageScreen> {
  static final TextEditingController titleController =
      TextEditingController();
  static final TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                  const SizedBox(height: 110,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        color: const Color(0xffe1e2e3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Enter the Title",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w800,color: Colors.black),
                                )),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xfff5f8fd),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextFormField(
                                controller: titleController,
                                style: TextStyle(fontSize: 15,color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "Enter the title of the message",
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Enter the Description",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w800,color: Colors.black),
                                )),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xfff5f8fd),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextFormField(
                                controller: descController,
                                style: TextStyle(fontSize: 15,color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "Enter the description of the message",
                                  hintStyle: TextStyle(color: Colors.black),
                                  fillColor:Colors.black ,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomMainButton(
                          color: Colors.deepPurpleAccent,
                          isLoading: false,
                          onPressed: _onClick,
                          child: const Text(
                            "SEND",
                            style: TextStyle(
                                letterSpacing: 0.6, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
          ),
        ));
  }
   void _onClick() async{
    
    if (_formKey.currentState!.validate())
      print(titleController.text);
      print(descController.text);
      try{

      final CollectionReference<Map<String, dynamic>> _collectionReference =
            FirebaseFirestore.instance.collection("messages");
        String id = DateTime.now().toString();
        await _collectionReference.doc(id).set({
          "type": titleController.text,
          "desc": descController.text,
          "time":id
        });

        await FirebaseFirestore.instance.collection("tokens").get().then((value) {
          value.docs.forEach((element) {sendMessage(element.get("token"), descController.text, titleController.text);});
        });
        ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Message Sent")));
        titleController.clear();
        descController.clear();
      }catch(e){
        print(e);
      }

      
  }

  void sendMessage(String token,String body,String title)async{

    try{
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String,String>{
        'Content-Type':'application/json',
        'Authorization':'key=AAAAOXoAFro:APA91bFTNdTgFRQMLmuEBSG0Q2gyfsUqgASJfm0mZiNKx_tTVrvVLqGKZDkuxunSN5VrK-VQC-_kI12HqYSqpIlM0RxRBSnhvlvub4fuE0mNzGKbNm8gM5E7USfHI4LHfnsH4WimGNXU',
        },
        body:jsonEncode(
          <String,dynamic>{
            'priority':'high',
            'data':<String,dynamic>{
              'click_action':'FLUTTER_NOTIFICATION_CLICK',
              'status':'done',
              'body':body,
              'title':title,
            },
            'notification':<String,dynamic>{
              
              'title':title,
              'body':body,
              'android_channel_id':'ChatBot',
            },
            'to':token,
          },
        )
      );
    }catch(e){
      print(e);
      print("error");
    }

  }
}


