import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/courses_category.dart';
import 'package:banktime/screens/courses_listing.dart';
import 'package:banktime/widget/app_style.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../error_page.dart';
import '../shared.dart';

class PremiumLessonsScreen extends StatefulWidget {
  const PremiumLessonsScreen({Key? key}) : super(key: key);

  @override
  _PremiumLessonsScreenState createState() => _PremiumLessonsScreenState();
}

class _PremiumLessonsScreenState extends State<PremiumLessonsScreen> {
  List<CoursesCategory> categories = [];
  var count = 0;
  bool login = false;
  String searchString = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //  Container(
          //                     decoration:
          //                         const BoxDecoration(color: Colors.white),
          //                     child: SizedBox(
          //                       width: double.infinity,
          //                       height: 60,
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(10),
          //                         child: TextField(
          //                           controller: searchController,
          //                           textAlign: TextAlign.left,
          //                           style: const TextStyle(
          //                               color: Color.fromRGBO(156, 156, 156, 1),
          //                               fontSize: 14),
          //                           decoration: InputDecoration(
          //                             prefixIcon: const Icon(Icons.search),
          //                             contentPadding: const EdgeInsets.only(
          //                                 left: 30, right: 30),
          //                             border: OutlineInputBorder(
          //                                 borderRadius:
          //                                     BorderRadius.circular(20),
          //                                 borderSide: BorderSide.none),
          //                             focusedBorder: OutlineInputBorder(
          //                               borderSide: const BorderSide(
          //                                   color:
          //                                       Color.fromRGBO(255, 202, 0, 1)),
          //                               borderRadius: BorderRadius.circular(20),
          //                             ),
          //                             hintText: 'Search for training courses',
          //                             hintStyle: const TextStyle(
          //                                 color:
          //                                     Color.fromRGBO(156, 156, 156, 1)),
          //                             filled: true,
          //                             fillColor: const Color.fromRGBO(
          //                                 242, 242, 242, 1),
          //                           ),
          //                           onChanged: (value) {
          //                             setState(() {
          //                               searchString = value;
          //                             });
          //                           },
          //                         ),
          //                       ),
          //                     ),
          //                   ),

          Expanded(
            child: FutureBuilder(
                future: fetchAllCategories(),
                builder: (ctx, AsyncSnapshot<List<CoursesCategory>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return SizedBox(
                          // height: MediaQuery.of(context).size.height - 179,
                          child: Center(
                        child: Text(
                          '${snapshot.error} occured',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ));
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 144,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/premium.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  'Masterclasses',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 18, 101, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: count,
                                  itemBuilder: (context, index) {
                                    CoursesCategory category =
                                        (snapshot.data as List)[index];
                                    return snapshot.data![index].name
                                            .contains(searchString)
                                        ? InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7.5),
                                              child: SizedBox(
                                                height: 140,
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              category
                                                                  .imageFullPath,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned.fill(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    .5)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          // ignore: prefer_const_literals_to_create_immutables
                                                          children: [
                                                            FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                  category.name,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    category.newCategory == 1
                                                        ? Positioned(
                                                            bottom: 0,
                                                            right: 0,
                                                            child: Image.asset(
                                                              "assets/images/new_lable.png",
                                                              width: 100,
                                                            ),
                                                          )
                                                        : Container(),
                                                    category.newCategory == 1
                                                        ? Positioned(
                                                            bottom: 20,
                                                            right: 10,
                                                            child: Transform
                                                                .rotate(
                                                              angle: -pi / 4,
                                                              child: Text(
                                                                  "NEW!",
                                                                  style: AppThemeData()
                                                                      .testStyle16Bold
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.white)),
                                                            ))
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () => {
                                              Navigator.of(context).push(
                                                CustomPageRoute(
                                                    child: CoursesListingScreen(
                                                        categoryId:
                                                            category.id)),
                                              )
                                            },
                                          )
                                        : Container();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                      // : Center(
                      //     child: SizedBox(
                      //         height:
                      //             MediaQuery.of(context).size.height - 100,
                      //         child: Column(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.center,
                      //             children: [
                      //               const Text(
                      //                 'You Must Login First !',
                      //                 style: TextStyle(
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 30,
                      //                 ),
                      //                 textAlign: TextAlign.center,
                      //               ),
                      //               Container(
                      //                 width: 220,
                      //                 height: 50,
                      //                 margin:
                      //                     const EdgeInsets.only(top: 60),
                      //                 child: ElevatedButton(
                      //                   child: const Text('Login',
                      //                       style: TextStyle(
                      //                           color: Colors.white,
                      //                           fontSize: 16,
                      //                           fontWeight:
                      //                               FontWeight.w600)),
                      //                   onPressed: () {
                      //                     Navigator.of(context,
                      //                             rootNavigator: true)
                      //                         .pushAndRemoveUntil(
                      //                             CustomPageRoute(
                      //                                 child:
                      //                                     const LoginScreen()),
                      //                             (_) => false);
                      //                   },
                      //                   style: ElevatedButton.styleFrom(
                      //                     primary: const Color.fromRGBO(
                      //                         19, 140, 237, 1),
                      //                     shape: RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           BorderRadius.circular(20),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //             ])),
                      //   );
                    } else {
                      return Container();
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Loading();
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<List<CoursesCategory>> fetchAllCategories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      (prefs.getBool('login') == null || false) ? login = false : login = true;

      Response response = await Shared(context).get("categories/for/1");
      var jsonData = jsonDecode(response.body);
      categories = (jsonData['categories'] as List)
          .map((category) => CoursesCategory.fromJson(category))
          .toList();
      count = categories.length;
      return categories;
    } on SocketException {
      Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(child: const ConnectionLostScreen()), (_) => false);
      return categories;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something Wrong, Please Try Again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return categories;
    }
  }
}
