import 'package:chatbot/model/message.dart';
import 'package:chatbot/screens/home/messages/cubit/messages_cubit.dart';
import 'package:chatbot/screens/widgets/new_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/errors.dart';
import '../../core/utils/local_notification_service.dart';
class UserMessageScreen extends StatefulWidget {
  const UserMessageScreen({super.key});

  @override
  State<UserMessageScreen> createState() => _UserMessageScreenState();
}

class _UserMessageScreenState extends State<UserMessageScreen> {
   List<MessageModel> MessageList=List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getAllMessages(context);

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  
  }
  

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
                onRefresh: ()async {
                  setState(() {
                    MessageList.clear();
                    print(MessageList);
                    _getAllMessages(context);
                  });
                  
                  },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: BlocBuilder<MessageCubit, MessageState>(
                      builder: (context, state) {
                        if (state is MessageInitial)
                          return _buildLoading(context);
                        else if (state is MessageSuccess)
                          return _buildSuccess(context, state.MessageList);
                        else if (state is MessageLoading)
                          return _buildLoading(context);
                        else
                          return Text("something went wrong");
                      },
                    ),
                  ),
              );
  }

  Widget _buildSuccess(BuildContext context, List<MessageModel> messageList) {
    double top = MediaQuery.of(context).viewInsets.top;
    double ratio = MediaQuery.of(context).size.aspectRatio;


    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          physics:BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            return MessageCard(
              // print(ComplaintList[index]);
              item: messageList[index],
            );
          },
        ),
      ),
    ) ; }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: CircularProgressIndicator());
  }

   void _getAllMessages(BuildContext context) {
    final cubit = context.read<MessageCubit>();
    cubit.getMessageList();
  }


 

                        
              

       
            
         
}