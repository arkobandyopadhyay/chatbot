import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obsecureText;
  final String hintText;
  const TextFieldWidget(
      {super.key,
      required this.title,
      required this.controller,
      required this.obsecureText,
      required this.hintText});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode focusNode;
  bool isInfocus = false;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isInfocus = true;
        });
      } else {
        setState(() {
          isInfocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                !isInfocus
                    ? BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    : BoxShadow(
                        color: Colors.orange.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
              ],
            ),
            child: TextField(
              focusNode: focusNode,
              obscureText: widget.obsecureText,
              controller: widget.controller,
              maxLines: 1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.hintText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
