import 'package:chatbot/screens/admin_dashboard/admin_screen.dart';
import 'package:chatbot/screens/admin_login/cubit/admin_login_cubit.dart';
import 'package:chatbot/screens/widgets/custom_main_button.dart';
import 'package:chatbot/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../admin_dashboard/admin_repository.dart';
import '../admin_dashboard/cubit/admin_cubit.dart';
import '../login_user/SignInScreen2.dart';
import '../login_user/cubit/login_user_cubit.dart';
import '../login_user/login_user_repository.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static final TextEditingController passwordController =
      TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginAdminCubit, LoginAdminState>(
        listener: (context, state) async {
          if (state is LoginAdminSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login Successful")));
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BlocProvider(
              create: (_) => AdminCubit(APIComplaintRepository()),
              child: AdminScreen()),));
            }
           else if (state is LoginAdminError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("error")));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is LoginAdminLoading)
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
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
        backgroundColor: const Color(0xffe8ebed),
        body: SingleChildScrollView(
          child: Container(
            height: screenSize
                .height, //For moving according to the screen when the keyboard popsup.
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 190,
                        width: 700,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/admin_login_image.jpg"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Admin Login",
                                  style: TextStyle(
                                      fontSize: 25,
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
                                validator: (String? email) => email!.isEmpty ? "" : null,
                                style: TextStyle(fontSize: 15,color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(fontSize: 15,color: Colors.black38),
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
                                  horizontal: 2, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xfff5f8fd),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 15,color: Colors.black),
                                controller: passwordController,
                                validator: (String? email) => email!.isEmpty ? "" : null,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontSize: 15,color: Colors.black38),
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.vpn_key, color: Colors.black),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                        child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w500),
                    )),
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
                          onPressed: () => _login(context),
                          child: const Text(
                            "Sign-In",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.6,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.blueGrey,
                      )),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "NOT AN ADMIN?",
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.blueGrey,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainButton(
                      color: Colors.grey,
                      isLoading: false,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => BlocProvider(
                                  create: (_) =>
                                      LoginUserCubit(APILoginRepository()),
                                  child: SignInScreen2()))));
                      },
                      child: const Text(
                        "Hostel Inmates Login",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.6,
                            color: Colors.black),
                      )),
                ])),
          ),
        ));
  }

  Widget _buildLoading(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  void _login(BuildContext context) {
    final cubit = context.read<LoginAdminCubit>();
    if (_formKey.currentState!.validate())
      print(emailController.text);
      print(passwordController.text);
      cubit.login(emailController.text, passwordController.text);
  }
}
