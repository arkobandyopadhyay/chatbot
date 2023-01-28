import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/screens/login_user/SignInScreen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../admin_login/SignInScreen.dart';
import '../admin_login/cubit/admin_login_cubit.dart';
import '../admin_login/login_admin_repository.dart';
import '../chatbot/Messages.dart';
import '../login_user/cubit/login_user_cubit.dart';
import '../login_user/login_user_repository.dart';

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
            fit: BoxFit.contain,
            ),
        ),
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.deepPurple,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
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
      if (response.message == null) return;
      else {
         final CollectionReference _collectionReference=FirebaseFirestore.instance.collection("complaints");
        await _collectionReference.add({"room":UserSimplePreferences.getRoom(),"type":response.message!.text!.text![0].substring(25),"isDone1":false,"isDone2":false,"image":"assets/"+ response.message!.text!.text![0].substring(25)+".jpg"});

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
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BlocProvider(
              create: (_) => LoginAdminCubit(APILoginAdminRepository()),
              child: SignInScreen()),));
        
    
  }
}
