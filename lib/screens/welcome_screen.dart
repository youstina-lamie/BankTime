// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/screens/auth_screens/login.dart';
import 'package:banktime/screens/auth_screens/register.dart';
import 'package:banktime/screens/questions_screens/clicker_intro.dart';
import 'package:banktime/widget/custom_button.dart';

import '../bottom_navbar.dart';
import '../loading.dart';
import '../shared.dart';

class WelcomeScreen extends StatefulWidget {
  final bool fromFirstQuestion;
  const WelcomeScreen({Key? key, required this.fromFirstQuestion})
      : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool visited = false;
  bool guest = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: WillPopScope(
              onWillPop: () async {
                if (widget.fromFirstQuestion) {
                  Navigator.pop(context);
                } else {
                  SystemNavigator.pop();
                }
                return false;
              },
              child: SingleChildScrollView(
                child: Column(children: [
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
                              'Welcome',
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
                        if (widget.fromFirstQuestion) {
                          Navigator.pop(context);
                        } else {
                          SystemNavigator.pop();
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage('assets/images/Artboard – 1.png'))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 243,
                            height: 243,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/welcome.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            'Sign Up To Save Dog Training Progress! Keep Track Of All The Tricks It Mastered',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          CustomButton(
                            onTap: () async {
                              setState(() => loading = true);

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              visited = prefs.getBool('visited') == null
                                  ? false
                                  : true;

                              guest = prefs.getBool('guest') == null
                                  ? false
                                  : prefs.getBool('guest')!;

                              if (guest == false) {
                                Response response =
                                    await Shared(context).get("users/guest");
                                var jsonData = jsonDecode(response.body);
                                if (response.statusCode == 200) {
                                  prefs.setInt('userId', jsonData['id']);
                                  prefs.setBool('guest', true);
                                  var dogs = prefs.getString('dogs') == null
                                      ? ''
                                      : prefs.getString('dogs')!;

                                  if (dogs != '') {
                                    var jsonDog = json.decode(dogs);
                                    Dog dog = Dog.fromJson(jsonDog[0]);

                                    Response responseAddDog =
                                        await Shared(context).post("dogs/new", {
                                      'name': dog.name,
                                      'breed': (dog.breed!.id).toString(),
                                      'gender': (dog.gender!.id).toString(),
                                      'date_of_birth':
                                          (dog.birthDate).toString(),
                                      'user_id': (jsonData['id']).toString()
                                    });
                                    prefs.remove('dogs');
                                  }
                                }
                              }
                              visited
                                  ? Navigator.of(context).pushAndRemoveUntil(
                                      CustomPageRoute(
                                          child: const Nav(
                                        pageIndex: 0,
                                      )),
                                      (_) => false)
                                  : Navigator.of(context).push(CustomPageRoute(
                                      child: const ClickerIntro()));
                            },
                            title: 'Continue As Guest',
                            titleStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            onTap: () {
                              Navigator.of(context).push(
                                  CustomPageRoute(child: const LoginScreen()));
                            },
                            title: 'Login',
                            titleStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            buttonColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            onTap: () {
                              Navigator.of(context).push(CustomPageRoute(
                                  child: const RegisterScreen()));
                            },
                            title: 'Create an Account',
                            titleStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            buttonColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
  }
}
