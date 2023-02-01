import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/screens/chatbot/Messages.dart';
import 'package:chatbot/screens/home/user_message_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../admin_dashboard/cubit/admin_cubit.dart';
import '../admin_login/SignInScreen.dart';
import '../admin_login/cubit/admin_login_cubit.dart';
import '../admin_login/login_admin_repository.dart';
import 'drawer/Drawer_repository.dart';
import 'drawer/cubit/drawer_cubit.dart';
import 'drawer_header.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        bottom: const TabBar(tabs: [
          Tab(icon: Icon(Icons.home),),
          Tab(icon: Icon(Icons.message),),
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
              UserMessageScreen(),
        ],
      ),
    ),);
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
      String textvalue = response.message!.text!.text![0].substring(25);
      if (textvalue == "emergency"||textvalue=="ambulance"||textvalue=="call caretaker") {
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
