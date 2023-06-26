// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChatWithUsScreen extends StatefulWidget {
  final bool closIcon;
  const ChatWithUsScreen({Key? key, required this.closIcon}) : super(key: key);
  @override
  _ChatWithUsScreenState createState() => _ChatWithUsScreenState();
}

class _ChatWithUsScreenState extends State<ChatWithUsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(19, 140, 237, 1)),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, top: 60, left: 20, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'banktime Premium',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/Artboard – 1.png'))),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: widget.closIcon
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            widget.closIcon
                                ? SizedBox(
                                    width: 25,
                                  )
                                : Container(),
                            const Text(
                              'banktime PREMIUM',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            widget.closIcon
                                ? InkWell(
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        width: 243,
                        height: 243,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage('assets/images/clickerIntroOne.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      const Text(
                        'NEED HELP WITH TRAINING',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: const Text(
                            'live chat with our trainers to get your questions answerd!',
                            style: TextStyle(fontSize: 14, height: 1.4),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 358,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(169, 58, 139, 1)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 34),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 20,
                                      alignment: Alignment.topCenter,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/Polygon.png'))),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    SizedBox(
                                        height: 56,
                                        child: ElevatedButton(
                                          child: const Text(
                                              'START 7-DAYS FREE TRIAL',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromRGBO(19, 140, 237, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                68,
                                        child: const Text(
                                          'Egp 1649 per year after free trail period',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        height: 56,
                                        child: ElevatedButton(
                                          child: const Text('SUBSCRIBE MONTHLY',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                68,
                                        child: const Text(
                                          'Egp 209.99 per month',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        )),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: const Text(
                                          'A Privacy Policy Is A Statement Or Legal Document (In Privacy Law) That Discloses Some Or All Of The Ways A Party Gathers, Uses, Discloses,',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              height: 1.4),
                                          textAlign: TextAlign.left,
                                        )),
                                    SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
