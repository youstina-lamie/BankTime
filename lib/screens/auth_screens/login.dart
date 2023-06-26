// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, null_check_always_fails, sized_box_for_whitespace, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/screens/auth_screens/register.dart';
import 'package:banktime/screens/auth_screens/reset_password.dart';
import 'package:banktime/screens/questions_screens/clicker_intro.dart';
import '../../bottom_navbar.dart';
import '../../shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  late bool visited;
  String dogs = '';

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 80, 92, 1)),
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, top: 60, left: 20, right: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Container()
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Container(
                        color: const Color.fromRGBO(247, 247, 247, 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(children: [
                            SizedBox(
                              height: 44,
                            ),
                            const Text('Add your details to login',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 37,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: email,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 27.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(12, 162, 185, 1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(12, 162, 185, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: 'Your Email',
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  isDense: true,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email required';
                                  } else if (!EmailValidator.validate(
                                      email.text)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 44,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: password,
                                obscureText: true,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 27.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                12, 162, 185, 1))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(12, 162, 185, 1)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromRGBO(156, 156, 156, 1)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 37,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 56,
                              child: ElevatedButton(
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  login();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(153, 206, 103, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Forgot your password?',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(CustomPageRoute(
                                                child:
                                                    const ResetPasswordScreen()));
                                      }),
                              ]),
                            ),
                            SizedBox(
                              height: 53,
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("Don't have an Account? ",
                                    style: TextStyle(fontSize: 14)),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Sign Up',
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(12, 162, 185, 1),
                                            fontSize: 14),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushReplacement(CustomPageRoute(
                                                    child:
                                                        const RegisterScreen()));
                                          }),
                                  ]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ]),
                        ),
                      ),
                    ],
                  )),
            ));
  }

  login() async {
    try {
      Navigator.of(context).pushAndRemoveUntil(
                    CustomPageRoute(
                        child: const Nav(
                      pageIndex: 0,
                    )),
                    (_) => false);
      // if (loginFormKey.currentState!.validate()) {
      //   var jsonResponse;
      //   setState(() => loading = true);

      //   Response response = await Shared(context).postLogin("users/login",
      //       jsonEncode({'email': email.text, 'password': password.text}));

      //   if (response.statusCode == 200) {
      //     jsonResponse = jsonDecode(response.body);
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     Navigator.of(context).pushAndRemoveUntil(
      //         CustomPageRoute(
      //             child: const Nav(
      //           pageIndex: 0,
      //         )),
      //         (_) => false);
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: "Invalid Email or Password.",
      //         toastLength: Toast.LENGTH_LONG,
      //         gravity: ToastGravity.BOTTOM,
      //         timeInSecForIosWeb: 1,
      //         backgroundColor: Colors.red,
      //         textColor: Colors.white,
      //         fontSize: 16.0);

      //     setState(() => loading = false);
      //   }
      // }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Invalid Email or Password",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
