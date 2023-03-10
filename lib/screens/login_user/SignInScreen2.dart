import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/screens/login_user/cubit/login_user_cubit.dart';
import 'package:chatbot/screens/signup_user/SignUpScreen.dart';
import 'package:chatbot/screens/widgets/custom_main_button.dart';
import 'package:chatbot/screens/home/home.dart';
import 'package:chatbot/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../signup_user/cubit/signup_user_cubit.dart';
import '../signup_user/signup_repository.dart';

class SignInScreen2 extends StatefulWidget {
  const SignInScreen2({super.key});
  @override
  State<SignInScreen2> createState() => _SignInScreen2State();
}

class _SignInScreen2State extends State<SignInScreen2> {
  static final TextEditingController passwordController =
      TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginUserCubit, LoginUserState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login Successful")));
            print(UserSimplePreferences.getEmail());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return const Home();
            })));
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is LoginLoading)
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
        backgroundColor: Colors.black54,
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
                        height:MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/chatbot image.png"),
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
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Student Login",
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
                                validator: (String? email) =>
                                    email!.isEmpty ? "" : null,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black38),
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
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                controller: passwordController,
                                validator: (String? email) =>
                                    email!.isEmpty ? "" : null,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.black38),
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.vpn_key, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
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
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
                          "Are you a new user?",
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
                                      SignupCubit(APISignupRepository()),
                                  child: SignupScreen()))));
                      },
                      child: const Text(
                        "Create an account",
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
    return Center(child: LottieBuilder.network("https://assets2.lottiefiles.com/private_files/lf30_lhLisE.json",width: 100,));
  }

  void _login(BuildContext context) {
    final cubit = context.read<LoginUserCubit>();
    if (_formKey.currentState!.validate()) print(emailController.text);
    print(passwordController.text);
    cubit.login(emailController.text, passwordController.text);
  }
}
