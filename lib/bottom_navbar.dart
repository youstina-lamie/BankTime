// ignore_for_file: nullable_type_in_catch_clause, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/error_page.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/breed.dart';
import 'package:banktime/model/gender.dart';
import 'package:banktime/my-globals.dart' as globals;
import 'package:banktime/screens/category_listing.dart';
import 'package:banktime/screens/chat_with_us.dart';
import 'package:banktime/screens/clicker_lesson.dart';
import 'package:banktime/screens/dogs_profile.dart';
import 'package:banktime/screens/web_view_store.dart';
import 'package:banktime/shared.dart';

import 'custom_page_route.dart';
import 'model/dog.dart';

class Nav extends StatefulWidget {
  final int pageIndex;

  const Nav({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  final GlobalKey<NavigatorState> _homeNavigatorState =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _chatNavigatorState =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _profileNavigatorState =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _clickerLessonNavigatorState =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _storeNavigatorState =
      GlobalKey<NavigatorState>();

  bool loading = false;
  int pageIndex = 0;
  int selectedPos = 0;
  List<Dog> dogsListing = [];
  late AudioPlayer player;
  int dogsLength = 0;
  Dog dogSelected = Dog(
      id: -1,
      name: '',
      birthDate: '',
      breed: Breed(id: -1, breed: ''),
      gender: Gender(id: -1, gender: ''));

  HomeTab currentTab = HomeTab.home;

  @override
  void initState() {
    super.initState();
    fetchDogs();
    pageIndex = widget.pageIndex;
    currentTab = HomeTab.values[pageIndex];
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return loading
        ? const Loading()
        : Scaffold(
            body: WillPopScope(
              onWillPop: () async {
                SystemNavigator.pop();
                return false;
              },
              child: Stack(
                children: [
                  _OffsetNavigator(
                    navigatorKey: _getNavigatorKey(HomeTab.home),
                    tab: HomeTab.home,
                    currentTab: currentTab,
                  ),
                  _OffsetNavigator(
                    navigatorKey: _getNavigatorKey(HomeTab.chat),
                    tab: HomeTab.chat,
                    currentTab: currentTab,
                  ),
                  _OffsetNavigator(
                    navigatorKey: _getNavigatorKey(HomeTab.profile),
                    tab: HomeTab.profile,
                    currentTab: currentTab,
                  ),
                  _OffsetNavigator(
                    navigatorKey: _getNavigatorKey(HomeTab.store),
                    tab: HomeTab.store,
                    currentTab: currentTab,
                  ),
                  _OffsetNavigator(
                    navigatorKey: _getNavigatorKey(HomeTab.clickerLesson),
                    tab: HomeTab.clickerLesson,
                    currentTab: currentTab,
                  ),
                ],
              ),
            ),
            floatingActionButton: Visibility(
              visible: keyboardIsOpen ? false : true,
              child: InkWell(
                onTap: () async {
                  await player.setAsset('assets/audio/clicker.mp3');
                  player.play();
                },
                child: Container(
                  height: 92,
                  width: 92,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 18, 101, 1),
                      image: DecorationImage(
                        image: AssetImage('assets/images/handPointer.png'),
                      )),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: buildMyNavBar(context),
          );
  }

  GlobalKey<NavigatorState> _getNavigatorKey(HomeTab homeTab) {
    switch (homeTab) {
      case HomeTab.home:
        return _homeNavigatorState;
      case HomeTab.chat:
        return _chatNavigatorState;
      case HomeTab.profile:
        return _profileNavigatorState;
      case HomeTab.clickerLesson:
        return _clickerLessonNavigatorState;
      case HomeTab.store:
        return _storeNavigatorState;
    }
  }

  Container buildMyNavBar(BuildContext context) {
    Dog? dogSelectedPro =
        Provider.of<globals.DogSelectedProvider>(context).dogSelectedProvider;

    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 18, 101, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: currentTab == HomeTab.home
                      ? const AssetImage('assets/images/home_fill.png')
                      : const AssetImage('assets/images/home.png'),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                pageIndex = 0;
                currentTab = HomeTab.home;
                checkVideoIsPlaying();
                final navigatorState =
                    _getNavigatorKey(currentTab).currentState;

                // pop to first route
                if (navigatorState != null) {
                  navigatorState.popUntil((route) => route.isFirst);
                }
              });
            },
          ),
          InkWell(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: currentTab == HomeTab.chat
                      ? const AssetImage('assets/images/livechat.png')
                      : const AssetImage('assets/images/chatUs.png'),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                pageIndex = 1;
                currentTab = HomeTab.chat;
                checkVideoIsPlaying();
                final navigatorState =
                    _getNavigatorKey(currentTab).currentState;

                // pop to first route
                if (navigatorState != null) {
                  navigatorState.popUntil((route) => route.isFirst);
                }
              });
            },
          ),
          Container(),
          InkWell(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: currentTab == HomeTab.store
                      ? const AssetImage('assets/images/store.png')
                      : const AssetImage('assets/images/market.png'),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                pageIndex = 2;
                currentTab = HomeTab.store;
                checkVideoIsPlaying();
                final navigatorState =
                    _getNavigatorKey(currentTab).currentState;

                // pop to first route
                if (navigatorState != null) {
                  navigatorState.popUntil((route) => route.isFirst);
                }
              });
            },
          ),
          Container(
              decoration: pageIndex == 3
                  ? BoxDecoration(
                      color: const Color.fromRGBO(19, 140, 248, 1),
                      shape: BoxShape.circle,
                      border: Border.all(width: 3.0, color: Colors.white))
                  : const BoxDecoration(),
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                    currentTab = HomeTab.profile;
                    checkVideoIsPlaying();
                    final navigatorState =
                        _getNavigatorKey(currentTab).currentState;

                    // pop to first route
                    if (navigatorState != null) {
                      navigatorState.popUntil((route) => route.isFirst);
                    }
                  });
                },
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: dogSelectedPro == null
                          ? dogSelected.id != 0 && dogSelected.image != null
                              ? Image.network(
                                  dogSelected.image!.originalUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/dogProfile.png',
                                  fit: BoxFit.cover,
                                )
                          : dogSelectedPro.image != null
                              ? Image.network(
                                  dogSelectedPro.image!.originalUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/dogProfile.png',
                                  fit: BoxFit.cover,
                                )),
                ),
              )),
        ],
      ),
    );
  }

  void checkVideoIsPlaying() {
    if (globals.chweiecontroller != null &&
        globals.chweiecontroller!.isPlaying == true) {
      globals.chweiecontroller!.pause();
      globals.chweiecontroller!.dispose();
      globals.controller!.dispose();
    }
  }

  Future<List<Dog>> fetchDogs() async {
    try {
      setState(() {
        loading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');

      Response response = await Shared(context).get("dogs/for-user/$userId");
      var jsonData = jsonDecode(response.body);
      dogsListing =
          (jsonData['Dogs'] as List).map((dog) => Dog.fromJson(dog)).toList();
      dogsLength = dogsListing.length;
      if (dogsLength != 0) {
        dogSelected =
            globals.currentDog != null ? globals.currentDog! : dogsListing[0];
      }

      setState(() {
        loading = false;
      });

      return dogsListing;
    } on SocketException {
      Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(child: const ConnectionLostScreen()), (_) => false);
      return dogsListing;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something Wrong, Please Try Again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return dogsListing;
    }
  }
}

enum HomeTab { home, chat, store, profile, clickerLesson }

class _OffsetNavigator extends StatelessWidget {
  const _OffsetNavigator(
      {Key? key,
      required this.navigatorKey,
      required this.currentTab,
      required this.tab})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final HomeTab currentTab;
  final HomeTab tab;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: currentTab != tab,
      child: TabNavigator(
        navigatorKey: navigatorKey,
        tabItem: tab,
        routeFactory: _getNavigatorRouteFactory(tab),
      ),
    );
  }

  RouteFactory _getNavigatorRouteFactory(HomeTab tab) {
    switch (tab) {
      case HomeTab.home:
        return TabNavigatorRouteFactory.homeFactory;
      case HomeTab.chat:
        return TabNavigatorRouteFactory.chatRouteFactory;
      case HomeTab.profile:
        return TabNavigatorRouteFactory.profileRouteFactory;
      case HomeTab.clickerLesson:
        return TabNavigatorRouteFactory.clickerLessonRouteFactory;
      case HomeTab.store:
        return TabNavigatorRouteFactory.storeRouteFactory;
    }
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    required this.navigatorKey,
    required this.tabItem,
    required this.routeFactory,
  });

  final GlobalKey<NavigatorState>? navigatorKey;
  final HomeTab tabItem;
  final RouteFactory routeFactory;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: routeFactory,
    );
  }
}

abstract class TabNavigatorRouteFactory {
  TabNavigatorRouteFactory._();

  static RouteFactory get homeFactory {
    return _routeFactory(_homePageScreenBuilder);
  }

  static RouteFactory get chatRouteFactory {
    return _routeFactory(_chatScreenBuilder);
  }

  static RouteFactory get profileRouteFactory {
    return _routeFactory(_profileScreenBuilder);
  }

  static RouteFactory get clickerLessonRouteFactory {
    return _routeFactory(_clickerLessonScreenBuilder);
  }

  static RouteFactory get storeRouteFactory {
    return _routeFactory(_storeScreenBuilder);
  }

  static Widget _homePageScreenBuilder(BuildContext context) =>
      const CategoryListingScreen();

  static Widget _chatScreenBuilder(BuildContext context) =>
      const ChatWithUsScreen(closIcon: false);

  static Widget _profileScreenBuilder(BuildContext context) =>
      const DogsProfileScreen();

  static Widget _storeScreenBuilder(BuildContext context) =>
      const WebViewScreen();

  static Widget _clickerLessonScreenBuilder(BuildContext context) =>
      const ClickerLesson(
        fromIntro: true,
      );

  static RouteFactory _routeFactory(WidgetBuilder widgetBuilder) {
    return (routeSettings) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: widgetBuilder,
      );
    };
  }
}
