import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  final String type;
  final String desc;
  final String time;
  
  //  final String time;

  MessageModel({required this.type, required this.desc, required this.time,});

  factory MessageModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return MessageModel(
      
      type: data["type"],
      desc: data["desc"],
      time: data["time"],
      
      // date:data['date'],
    );
  }
}