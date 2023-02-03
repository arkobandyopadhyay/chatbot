import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/complaint_model.dart';

class ItemWidget extends StatefulWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
            leading: Column(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(widget.item.image),
                  ),
                ),
                // Text(widget.item.time.substring(0,10))
              ],
            ),
            title: Text(widget.item.type),
            subtitle: Text("Room No: ${widget.item.roomno}"),
            trailing: Column(
              children: [
                Expanded(
                  child: Container(
                
                    child: Checkbox(
                        splashRadius: 10,
                        shape: CircleBorder(),
                        value: isChecked,
                        onChanged: (bool? value) async{
                            
                    
                    await FirebaseFirestore.instance.collection("complaints").doc(widget.item.time).update({"isDone1":value});
                            
                          // widget.item.isDone1=true;
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                  ),
                ),
                SizedBox(height: 5,),
                Text(widget.item.time.substring(0,10))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
