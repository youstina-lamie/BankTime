// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/screens/auth_screens/login.dart';
import 'package:banktime/screens/auth_screens/register.dart';
import 'package:banktime/widget/custom_button.dart';

import '../loading.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key})
      : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool visited = false;
  
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
                SystemNavigator.pop();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 80, 92, 1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, top: 60, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Container(),
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
                  ),
                  Container(
                    color: const Color.fromRGBO(247, 247, 247, 1),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 225,
                            height: 225,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/welcomePage.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            'Lets Join Our Community',
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
                            buttonColor: const Color.fromRGBO(153, 206, 103, 1),
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
                            buttonColor: const Color.fromRGBO(153, 206, 103, 1),
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
