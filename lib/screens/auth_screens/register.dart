// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/bottom_navbar.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/screens/auth_screens/login.dart';
import 'package:banktime/screens/questions_screens/clicker_intro.dart';

import '../../loading.dart';
import '../../shared.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loading = false;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool passwordNotMatch = false;
  late bool visited;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                              'Sign Up',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: registerFormKey,
                      child: Column(children: [
                        SizedBox(
                          height: 44,
                        ),
                        Text('Add your details to sign up',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 37,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: name,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 27.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(12, 162, 185, 1))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(12, 162, 185, 1)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 46,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.left,
                            style: TextStyle(
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 27.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(12, 162, 185, 1))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(12, 162, 185, 1)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email required';
                              } else if (!EmailValidator.validate(email.text)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 46,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: mobile,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9]+$'),
                              ),
                            ],
                            textAlign: TextAlign.left,
                            style: TextStyle(
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 27.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(12, 162, 185, 1))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(12, 162, 185, 1)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'Mobile No',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              String pattern = r'^(?:[+0]6)?[0-9]{11}$';
                              RegExp regExp = RegExp(pattern);
                              if (value!.isEmpty) {
                                return 'Mobile number required';
                              } else if (!regExp.hasMatch(value)) {
                                return "Please enter a valid mobile number";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 46,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: address,
                            textAlign: TextAlign.left,
                            style: TextStyle(
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 27.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(12, 162, 185, 1))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(12, 162, 185, 1)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'Address',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Address required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 46,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 27.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(12, 162, 185, 1))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(12, 162, 185, 1)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1)),
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
                          height: 46,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: confirmPassword,
                            obscureText: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(
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
                                errorMaxLines: passwordNotMatch ? 2 : 1,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 27.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(12, 162, 185, 1))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(12, 162, 185, 1)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  passwordNotMatch = false;
                                });
                                return 'Confirm Password required';
                              }
                              if (value != password.text) {
                                setState(() {
                                  passwordNotMatch = true;
                                });
                                return 'Password and confirm password not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 38,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          child: ElevatedButton(
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              signUp();
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Already have an Account?",
                                style: TextStyle(fontSize: 14)),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(12, 162, 185, 1),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushReplacement(
                                          CustomPageRoute(
                                              child: const LoginScreen()),
                                        );
                                      }),
                              ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 44,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }

  signUp() async {
    try {
      if (registerFormKey.currentState!.validate()) {
        var jsonResponse;
        setState(() => loading = true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Response response;
        if (prefs.getInt('userId') == null) {
          response = await Shared(context).postLogin(
              "users/new",
              jsonEncode({
                'name': name.text,
                'mobile': mobile.text,
                'email': email.text,
                'address': address.text,
                'password': password.text
              }));
        } else {
          response = await Shared(context).postLogin(
              "users/new",
              jsonEncode({
                'name': name.text,
                'mobile': mobile.text,
                'email': email.text,
                'address': address.text,
                'password': password.text,
                'id': prefs.getInt('userId')!
              }));
        }

        if (response.statusCode == 200) {
          jsonResponse = jsonDecode(response.body);
          print(jsonResponse);
          if (jsonResponse['user'] == null) {
            setState(() => loading = false);
            Fluttertoast.showToast(
                msg: "This email already has account.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            prefs.setBool('guest', false);
            prefs.setInt('userId', jsonResponse['user']['id']);
            String dogs =
                prefs.getString('dogs') == null ? '' : prefs.getString('dogs')!;
            if (dogs != '') {
              var jsonDog = json.decode(dogs);
              Dog dog = Dog.fromJson(jsonDog[0]);
              Response responseAddDog = await Shared(context).post("dogs/new", {
                'name': dog.name,
                'breed': (dog.breed!.id).toString(),
                'gender': (dog.gender!.id).toString(),
                'date_of_birth': dog.birthDate.toString(),
                'user_id': (jsonResponse['user']['id']).toString()
              });
              prefs.remove('dogs');
            }
            visited = prefs.getBool('visited') == null ? false : true;

            visited
                ? Navigator.of(context).pushAndRemoveUntil(
                    CustomPageRoute(
                        child: Nav(
                      pageIndex: 0,
                    )),
                    (_) => false)
                : Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    CustomPageRoute(child: const ClickerIntro()), (_) => false);
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Invalid Email or Password.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
