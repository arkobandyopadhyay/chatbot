import 'dart:convert';

import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/screens/chatbot/Messages.dart';
import 'package:chatbot/screens/home/user_message_screen.dart';
import 'package:chatbot/screens/home/user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher_string.dart';

import '../admin_login/SignInScreen.dart';
import '../admin_login/cubit/admin_login_cubit.dart';
import '../admin_login/login_admin_repository.dart';
import 'drawer/Drawer_repository.dart';
import 'drawer/cubit/drawer_cubit.dart';
import 'drawer_header.dart';
import 'messages/cubit/messages_cubit.dart';
import 'messages/message_repository.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>   {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  // late TabController _tabController = TabController(length: 4, vsync: this);
  bool check = false;

  List<Map<String, dynamic>> messages = [];

  // late stt.SpeechToText _speech;
  // bool _isListening = false;
  // late String _text;
  // double _confidence = 1.0;

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    // _speech = stt.SpeechToText();
    super.initState();
  }
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.purpleAccent,
          title: Text('Hostel Hubby'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                _onClick();
              },
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.message),
            ),
            Tab(
              icon: Icon(Icons.call),
            ),
          ]),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  BlocProvider(
                      create: (_) => DrawerCubit(APIDrawerRepository()),
                      child: HeaderDrawer()),
                  // MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          // controller: _tabController,
          children: [
            Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/chatbot_image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              child: Column(
                children: [
                  Expanded(child: MessagesScreen(messages: messages)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    color: Colors.black26,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _controller,
                          decoration: new InputDecoration.collapsed(
                            hintText: 'Start typing your Complaint...',
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(color: Colors.white),
                        )),
                        IconButton(
                            onPressed: () async {
                              if (check) {
                                setState(() {
                                  check = false;
                                });
                                final CollectionReference<Map<String, dynamic>>
                                    _collectionReference = FirebaseFirestore
                                        .instance
                                        .collection("complaints");

                                String id = DateTime.now().toString();
                                await _collectionReference.doc(id).set({
                                  "room": UserSimplePreferences.getRoom(),
                                  "type": _controller.text,
                                  "time": id,
                                  "isDone1": false,
                                  "isDone2": false,
                                  "image": "assets/default.png"
                                });
                                await FirebaseFirestore.instance
                                    .collection("tokens")
                                    .get()
                                    .then((value) {
                                  value.docs.forEach((element) {
                                    postMessage(
                                        element.get("token"),
                                        _controller.text.toString(),
                                        "COMPLAINT");
                                  });
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Complaint Registered"),
                                  backgroundColor: Colors.green,
                                ));
                              }
                              sendMessage(_controller.text);
                              _controller.clear();
                            },
                            icon: Icon(Icons.send))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: BlocProvider(
                  create: (_) => MessageCubit(APIMessageRepository()),
                  child: UserMessageScreen()),
            ),
            Container(child: UserCallScreen()),
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;

      if (response.message!.text!.text![0] ==
          "Okay, Please write below your queries!!!") {
        setState(() {
          check = true;
        });
      }

      if (response.message!.text!.text![0].length >= 24) {
        String textvalue = response.message!.text!.text![0].substring(25);
        if (textvalue == "emergency" ||
            textvalue == "ambulance" ||
            textvalue == "call caretaker") {
          //return FlutterPhoneDirectCaller.callNumber('+918770904101');
          launchUrlString('tel: 8770904101');
        }
        if (textvalue == "Electric Supply" ||
            textvalue == "room clean" ||
            textvalue == "water supply" ||
            textvalue == "food quality" ||
            textvalue == "lift problem" ||
            textvalue == "broken furniture" ||
            textvalue == "washroom" ||
            textvalue == "Lost Item") {
          // String? id = UserSimplePreferences.getId();
          final CollectionReference<Map<String, dynamic>> _collectionReference =
              FirebaseFirestore.instance.collection("complaints");
          String textvalue = response.message!.text!.text![0].substring(25);
          String id = DateTime.now().toString();
          await _collectionReference.doc(id).set({
            "room": UserSimplePreferences.getRoom(),
            "type": textvalue,
            "time": id,
            "isDone1": false,
            "isDone2": false,
            "image": "assets/" + textvalue + ".jpg"
          });
          await FirebaseFirestore.instance
              .collection("tokens")
              .get()
              .then((value) {
            value.docs.forEach((element) {
              postMessage(element.get("token"), textvalue, "COMPLAINT");
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Complaint Registered"),
            backgroundColor: Colors.green,
          ));
        }
      }

      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  Future<void> _onClick() async {
    UserSimplePreferences.erase();

    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
      ]);
    } catch (e) {
      print(e);
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Logged Out Successfuly")));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BlocProvider(
          create: (_) => LoginAdminCubit(APILoginAdminRepository()),
          child: SignInScreen()),
    ));
  }
}

void postMessage(param0, String textvalue, String s) {
}