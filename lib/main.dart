import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/bottom_navbar.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/my-globals.dart';
import 'package:banktime/screens/questions_screens/first_question.dart';
import 'package:banktime/screens/welcome_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(19, 140, 237, 1)));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DogSelectedProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // fontFamily: "Gotham",
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        locale: const Locale("en", "US"),
        supportedLocales: const [
          Locale('ar', 'EG'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool guest;
  late bool visited;

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(19, 140, 248, 1),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/logo-png-w-768x157@2x.png",
                  height: 300.0,
                  width: 300.0,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  timer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    guest = prefs.getBool('guest') == null ? true : prefs.getBool('guest')!;
    visited = prefs.getBool('visited') == null ? false : true;

    Timer(
        const Duration(seconds: 2),
        () async => Navigator.pushReplacement(
            context,
            CustomPageRoute(
                child: visited
                    ? (guest
                        ? const WelcomeScreen(
                            fromFirstQuestion: false,
                          )
                        : const Nav(pageIndex: 0))
                    : const FirstQuestionScreen())));
  }
}
