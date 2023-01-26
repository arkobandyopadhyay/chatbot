import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          20,
                        ),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 0 : 20),
                        topLeft: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 20 : 0),
                      ),
                      color: widget.messages[index]['isUserMessage']
                          ? Colors.grey.shade800
                          : Colors.grey.shade900.withOpacity(0.8)),
                  constraints: BoxConstraints(maxWidth: w * 2 / 3),
                  child: widget.messages[index]['isUserMessage'] == false
                      ? function(widget.messages[index]['message'].text.text[0])
                      : Text(widget.messages[index]['message'].text.text[0]),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}

Widget function(String text) {
  return Column(
    children: [
      if (text.substring(25) == "Electric Supply") ...[
        Text(text),
      ]else if(text.substring(25)=="food quality")...[
        Text(text),
      ]else if(text.substring(25)=="room clean")...[
        Text(text),
      ]else if(text.substring(25)=="water supply")...[
        Text(text),
      ] else ...[
        Text(text)
      ]
    ],
  );
}
