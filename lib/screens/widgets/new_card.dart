import 'package:flutter/material.dart';

import '../../model/message.dart';
class MessageCard extends StatefulWidget {
  final MessageModel item;
  const MessageCard({Key? key, required this.item}) : super(key: key);
  

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(left: 5,right: 5),
      child:  Container(
        padding: const EdgeInsets.only(left: 5,right: 5),
        height: 100,
        child: Container(
      height: 70,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              print("${widget.item.type} pressed");
            },
            leading: Icon(Icons.admin_panel_settings,color: Colors.green,),
            title: Text(widget.item.type.toUpperCase()),
            subtitle: Text(widget.item.desc),
            trailing: Text(widget.item.time.substring(0,10)),

              
                
                ),
          ),
        ),
      ),
      )); 
  }
}