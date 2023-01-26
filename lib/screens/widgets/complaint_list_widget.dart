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
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              print("${widget.item.type} pressed");
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.item.image),
            ),
            title: Text(widget.item.type),
            subtitle: Text("Room No: ${widget.item.roomno}"),
            trailing: Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
