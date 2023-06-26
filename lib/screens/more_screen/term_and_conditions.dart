import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../custom_page_route.dart';
import '../../error_page.dart';
import '../../loading.dart';
import '../../shared.dart';

class TermAndConditionsScreen extends StatefulWidget {
  const TermAndConditionsScreen({Key? key}) : super(key: key);
  @override
  _TermAndConditionsScreenState createState() =>
      _TermAndConditionsScreenState();
}

class _TermAndConditionsScreenState extends State<TermAndConditionsScreen> {
  bool loading = false;
  late String content;

  @override
  void initState() {
    super.initState();
    getTermsAndConditions();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
            child: Column(
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
                            'Term And Conditions',
                            style: TextStyle(
                                fontSize: 22,
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
                          image: AssetImage('assets/images/Artboard – 1.png'))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 15, top: 15),
                        child: Html(data: content),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
  }

  getTermsAndConditions() async {
    try {
      loading = true;
      var response = await Shared(context).get("terms");
      content = jsonDecode(response.body)['terms']['content'];
      setState(() {
        loading = false;
      });
    } on SocketException {
      Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(child: const ConnectionLostScreen()), (_) => false);
    } catch (e) {
      // print(e);
      Fluttertoast.showToast(
        msg: "Something Wrong, Please Try Again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }
}
