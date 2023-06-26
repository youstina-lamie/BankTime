// ignore_for_file: avoid_print

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:banktime/loading.dart';

import '../../custom_page_route.dart';
import '../../error_page.dart';
import '../../shared.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool loading = false;
  GlobalKey<FormState> contactUsFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController msgTitle = TextEditingController();
  TextEditingController message = TextEditingController();

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
            body: SingleChildScrollView(
              child: Form(
                key: contactUsFormKey,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 18, 101, 1)),
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
                                'Contact Us',
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
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  'assets/images/Artboard – 1.png'))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 53,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: name,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
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
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(
                                              255, 18, 101, 114))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(255, 18, 101, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
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
                            const SizedBox(
                              height: 30,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
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
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(
                                              255, 18, 101, 114))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(255, 18, 101, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
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
                            const SizedBox(
                              height: 30,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mobile No',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]+$'),
                                  ),
                                ],
                                controller: mobile,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
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
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(
                                              255, 18, 101, 114))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(255, 18, 101, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
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
                            const SizedBox(
                              height: 30,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Message Title',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: msgTitle,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 27.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(
                                              255, 18, 101, 114))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(255, 18, 101, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Message',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: message,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
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
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(
                                              255, 18, 101, 114))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(255, 18, 101, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Message required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 42,
                              width: 125,
                              child: ElevatedButton(
                                child: const Text('Send',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  sendMessage();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 103,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  sendMessage() async {
    try {
      if (contactUsFormKey.currentState!.validate()) {
        setState(() => loading = true);
        Response response = await Shared(context).post("contact/new", {
          'name': name.text,
          'email': email.text,
          'mobile': mobile.text,
          'msg_title': msgTitle.text,
          'msg': message.text,
        });

        if (response.statusCode == 200) {
          email.text = '';
          mobile.text = '';
          name.text = '';
          msgTitle.text = '';
          message.text = '';

          setState(() => loading = false);
        } else {
          setState(() => loading = false);
          Fluttertoast.showToast(
              msg: "Poor connection, Check your network Connection.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } on SocketException {
      Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(child: const ConnectionLostScreen()), (_) => false);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something Wrong, Please Try Again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
