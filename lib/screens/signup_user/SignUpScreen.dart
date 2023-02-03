import 'package:chatbot/screens/login_user/SignInScreen2.dart';
import 'package:chatbot/screens/signup_user/cubit/signup_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../home/home.dart';
import '../login_user/cubit/login_user_cubit.dart';
import '../login_user/login_user_repository.dart';
import '../widgets/custom_main_button.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController hostelController = TextEditingController();
  void dispose() {
    emailController;
    passwordController;
    roomController;
    hostelController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is SignupSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("SignUp Successful")));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return const Home();
            })));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is SignupLoading)
                _buildLoading(context)
              else
                _buildInitial(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 70,
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.28),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 20,),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Enter your Email ID",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
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
                                controller: emailController,
                                validator: (String? email) =>
                                    email!.isEmpty ? "" : null,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "email id",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black38),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.abc,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Set Your Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                controller: passwordController,
                                validator: (String? email) =>
                                    email!.isEmpty ? "" : null,
                                decoration: const InputDecoration(
                                  hintText: "Type a password",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black38),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.abc,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Enter your Room No",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                controller: roomController,
                                validator: (String? email) =>
                                    email!.isEmpty ? "" : null,
                                decoration: const InputDecoration(
                                  hintText: "write your room no",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black38),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.abc,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Enter your Hostel",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                controller: hostelController,
                                validator: (String? email) =>
                                    email!.isEmpty ? "" : null,
                                decoration: const InputDecoration(
                                  hintText: "write your hostel name in captial like A,B",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black38),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.abc,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomMainButton(
                                      color: Colors.deepPurpleAccent,
                                      isLoading: false,
                                      onPressed: () {
                                        _signup(context);
                                      },
                                      child: const Text(
                                        "Sign-Up",
                                        style: TextStyle(
                                            fontSize: 15,
                                            letterSpacing: 0.6,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ]),
                    ),
                  ),
                ])),
          ),
        ));
  }

  Widget _buildLoading(BuildContext context) {
    return Center(child: LottieBuilder.network("https://assets2.lottiefiles.com/private_files/lf30_lhLisE.json",width: 100,));
  }

  void _signup(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    if (_formKey.currentState!.validate())
      cubit.signup(
        emailController.text,
        passwordController.text,
        roomController.text,
      );
  }
}
