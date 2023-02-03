import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/complaint_model.dart';

class DailerWidget extends StatefulWidget {
  final String number;
  final String name;

  const DailerWidget({Key? key, required this.number,required this.name}) : super(key: key);

  @override
  State<DailerWidget> createState() => _DailerWidgetState();
}

class _DailerWidgetState extends State<DailerWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              print("${widget.number} pressed");
            },
            leading: Icon(Icons.assignment_ind_outlined,color: Colors.blue,),
            title: Text(widget.name.toUpperCase()),
            trailing: IconButton(
              icon:Icon(Icons.call,color: Colors.green,),
               onPressed: () { 
                launchUrlString(widget.number);
                },

              
                
                ),
          ),
        ),
      ),
    );
  }
}
