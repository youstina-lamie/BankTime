// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../shared.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Form(
            key: resetPasswordFormKey,
            child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(19, 140, 237, 1)),
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
                                'Reset Password',
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
                    child: Column(
                      children: [
                        SizedBox(height: 44,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width ,
                          child: Text('Please enter your email to receive a link to create a new password via email',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,height: 1.4
                            )
                          )
                        ),
                        SizedBox(height: 30,),

                          SizedBox(
                            width: MediaQuery.of(context).size.width ,
                            child: TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(156, 156, 156, 1),
                                  fontSize: 14),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 27.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color.fromRGBO(19, 140, 237, 1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(19, 140, 237, 1)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  isDense: true),
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
                        SizedBox(height: 30,),

                          SizedBox(
                            width: MediaQuery.of(context).size.width ,
                            height: 56,
                            child: ElevatedButton(
                              child: const Text('Send',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                sendToMyMail();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(19, 140, 237, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),


                ])));
  }

  sendToMyMail() async {
    try {
      if (resetPasswordFormKey.currentState!.validate()) {
        Response response = await Shared(context).post("users/reset-password", {
          'email': email.text,
        });
        var jsonData = jsonDecode(response.body);

        if (jsonData['error'] != null) {
          Fluttertoast.showToast(
            msg: jsonData['error'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
          
        } else {
          Fluttertoast.showToast(
            msg: jsonData['msg'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
          
        }

        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (ctx) => const DogsListingScreen()));
      }
    } catch (e) {
      print('error caught: $e');
    }
  }
}
