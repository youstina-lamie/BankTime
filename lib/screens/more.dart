import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/screens/auth_screens/login.dart';
import 'package:banktime/screens/chat_with_us.dart';
import 'package:banktime/screens/clicker_lesson.dart';
import 'package:banktime/screens/more_screen/contact_us.dart';
import 'package:banktime/screens/more_screen/privacy_policy.dart';
import 'package:banktime/screens/more_screen/term_and_conditions.dart';
import 'package:banktime/screens/welcome_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool login = false;
  @override
  initState() {
    super.initState();
    getLogin();
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
                    const BoxDecoration(color: Color.fromRGBO(255, 18, 101, 1)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const Text(
                        'More',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 130,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Artboard – 1.png'))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(CustomPageRoute(
                                  child:
                                      const ClickerLesson(fromIntro: false)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 25,
                                  height: 35,
                                  child: Image.asset(
                                      'assets/images/clickerMore.png'),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1)),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, top: 15),
                                      child: Text(
                                        'Clicker Tutorial',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  CustomPageRoute(
                                      child: const TermAndConditionsScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 25,
                                  height: 35,
                                  child: Image.asset(
                                      'assets/images/termsAndConditions.png'),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1)),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, top: 15),
                                      child: Text(
                                        'Term And Conditions',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  CustomPageRoute(
                                      child: const PrivacyPolicyScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 25,
                                  height: 35,
                                  child:
                                      Image.asset('assets/images/privacy.png'),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1)),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, top: 15),
                                      child: Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  CustomPageRoute(
                                      child: const ContactUsScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 25,
                                  height: 35,
                                  child: Image.asset(
                                      'assets/images/contactUs.png'),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1)),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, top: 15),
                                      child: Text(
                                        'Contact Us',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: login ? true : false,
                            child: InkWell(
                              onTap: () async {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: const Text(
                                      'Are you sure you want to logout ? ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(height: 1.5),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              child: TextButton(
                                                onPressed: () => {logout()},
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        19, 140, 237, 1),
                                              ),
                                            ),
                                          ])
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    width: 25,
                                    height: 35,
                                    child: const Icon(
                                      FontAwesomeIcons.arrowRightFromBracket,
                                      color: Color.fromRGBO(255, 18, 101, 1),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, top: 15),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: login ? false : true,
                            child: InkWell(
                              onTap: () async {
                                Navigator.of(context, rootNavigator: true).push(
                                  CustomPageRoute(child: const LoginScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    width: 25,
                                    height: 35,
                                    child: const Icon(
                                      FontAwesomeIcons.arrowRightToBracket,
                                      color: Color.fromRGBO(255, 18, 101, 1),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, top: 15),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(169, 58, 139, 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Text(
                                  'Get banktime Premium',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                            const Text(
                                'Unlock All Lesson Packs,Get Personal Training Help,And More.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 1.3),
                                textAlign: TextAlign.center)
                          ]),
                        ),
                      ),
                      onTap: () => {
                        Navigator.of(context, rootNavigator: true).push(
                            CustomPageRoute(
                                child: const ChatWithUsScreen(closIcon: true)))
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('guest') == false ? login = true : login = false;
    setState(() {
      login = login;
    });
  }

  logout() async {
    if (login == true) {
      Navigator.of(context).pop();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userId');
      prefs.remove('guest');
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          CustomPageRoute(
              child: const WelcomeScreen()),
          (_) => false);
    }
  }
}
