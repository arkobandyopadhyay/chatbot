import 'package:flutter/material.dart';

import '../../model/complaint_model.dart';
class CustomCard extends StatefulWidget {
  final Item item;
  const CustomCard({Key? key, required this.item}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(left: 5,right: 5),
      child:  Center(
          child: ListTile(
            onTap: () {
              print("${widget.item.type} pressed");
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.item.image),
            ),
            title: Text(widget.item.type),
            subtitle: Text("Date: ${widget.item.time.substring(0,10)}"),
            trailing: widget.item.isDone1?Icon(Icons.done,color: Colors.green):Icon(Icons.pending,color: Colors.yellow,),
            
          ),
        )); 
  }
}