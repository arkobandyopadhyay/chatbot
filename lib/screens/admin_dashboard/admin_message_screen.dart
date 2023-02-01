import 'package:chatbot/screens/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';

class AdminMessageScreen extends StatefulWidget {
  const AdminMessageScreen({super.key});
  @override
  State<AdminMessageScreen> createState() => _AdminMessageScreenState();
}

class _AdminMessageScreenState extends State<AdminMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                  const SizedBox(height: 110,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        color: const Color(0xffe1e2e3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: const Text(
                                "Enter the Title",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800,color: Colors.black),
                              )),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f8fd),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(color: Colors.black),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Enter the title of the message",
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: const Text(
                                "Enter the Description",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800,color: Colors.black),
                              )),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f8fd),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(color: Colors.black),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Enter the description of the message",
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomMainButton(
                          color: Colors.deepPurpleAccent,
                          isLoading: false,
                          onPressed: () {},
                          child: const Text(
                            "SEND",
                            style: TextStyle(
                                letterSpacing: 0.6, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
          ),
        ));
  }
}
