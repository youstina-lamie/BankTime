import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:banktime/bottom_navbar.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/widget/app_style.dart';
import 'package:banktime/widget/custom_button.dart';

class ClickerIntro extends StatefulWidget {
  const ClickerIntro({Key? key}) : super(key: key);

  @override
  _ClickerIntroState createState() => _ClickerIntroState();
}

class _ClickerIntroState extends State<ClickerIntro> {
  final GlobalKey _one = GlobalKey();
  bool showQuide = false;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('dogs');
        return false;
      },
      child: ShowCaseWidget(
        onFinish: turnVoice,
        builder: Builder(
            builder: (context) => Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(19, 140, 237, 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, top: 60, left: 20, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              'Clicker Intro',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'You Just Used A Clicker!',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: 243,
                            height: 243,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/clickerIntroOne.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          const Text(
                            'Continue To The Clicker Tutorial To Learn How To Use It For Positive Reinforcement Training.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            onTap: () async {
                              if (showQuide) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('visited', true);
                                Navigator.of(context).pushAndRemoveUntil(
                                    CustomPageRoute(
                                      child: const Nav(pageIndex: 4),
                                    ),
                                    (_) => false);
                              } else {
                                ShowCaseWidget.of(context)
                                    .startShowCase([_one]);
                                setState(() {
                                  showQuide = true;
                                });
                              }
                            },
                            title: 'Continue',
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
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('visited', true);
                              Navigator.of(context).pushAndRemoveUntil(
                                  CustomPageRoute(
                                      child: const Nav(
                                    pageIndex: 0,
                                  )),
                                  (_) => false);
                            },
                            title: 'Maybe Later',
                            titleStyle: AppThemeData()
                                .testStyle18Bold
                                .copyWith(color: AppThemeData().whiteColor),
                            buttonColor: AppThemeData().blackColor,
                          ),
                          const SizedBox(
                            height: 69,
                          )
                        ],
                      ),
                    )
                  ]),
                ),
                floatingActionButton: Showcase.withWidget(
                    key: _one,
                    height: 80,
                    width: 140,
                    shapeBorder: const CircleBorder(),
                    radius: const BorderRadius.all(Radius.circular(150)),
                    container: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Try",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                        RotationTransition(
                          turns: const AlwaysStoppedAnimation(-15 / 360),
                          child: Container(
                            width: 74,
                            height: 138,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/arrow.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        turnVoice();
                      },
                      child: Container(
                        height: 92,
                        width: 92,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(19, 140, 237, 1),
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/handPointer.png'),
                            )),
                      ),
                    )),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(19, 140, 237, 1),
                  ),
                  child: Container(),
                ))),
      ),
    );
  }

  turnVoice() async {
    await player.setAsset('assets/audio/clicker.mp3');
    player.play();
  }
}
