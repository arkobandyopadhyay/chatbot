import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/screens/chatbot/Messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../admin_login/SignInScreen.dart';
import '../admin_login/cubit/admin_login_cubit.dart';
import '../admin_login/login_admin_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI ChatBot'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              _onClick();
            },
          ),
        ],
      ),
      body: Container(
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
                      onPressed: () {
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
      if (response.message == null)
        return;
      String textvalue = response.message!.text!.text![0].substring(25);
      if (textvalue == "Electric Supply" ||textvalue == "room clean" ||textvalue == "water supply" ||textvalue == "food quality" ||textvalue == "lift problem" ||textvalue == "broken furniture" ||textvalue == "washroom" ||textvalue == "Lost Item"){
        final CollectionReference _collectionReference =
            FirebaseFirestore.instance.collection("complaints");
        String textvalue = response.message!.text!.text![0].substring(25);
        await _collectionReference.add({
            "room": UserSimplePreferences.getRoom(),
            "type": textvalue,
            "isDone1": false,
            "isDone2": false,
            "image": "assets/" +
                textvalue +
                ".jpg"
          });
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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Logged Out Successfuly")));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BlocProvider(
          create: (_) => LoginAdminCubit(APILoginAdminRepository()),
          child: SignInScreen()),
    ));
  }
}
