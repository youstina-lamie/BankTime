// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unused_local_variable
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/error_page.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/course.dart';
import 'package:banktime/model/courses_category.dart';
import 'package:banktime/screens/course_details.dart';

import '../shared.dart';

class CoursesListingScreen extends StatefulWidget {
  final int categoryId;

  const CoursesListingScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _CoursesListingScreenState createState() => _CoursesListingScreenState();
}

class _CoursesListingScreenState extends State<CoursesListingScreen> {
  List<CoursesCategory> category = [];
  List<Course> courses = [];
  bool loading = false;

  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : FutureBuilder(
            future: fetchAllCourses(),
            builder: (ctx, AsyncSnapshot<List<CoursesCategory>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return SizedBox(
                      child: Center(
                    child: Text(
                      '${snapshot.error} occured',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ));
                } else if (snapshot.hasData) {
                  return Scaffold(
                    body: SingleChildScrollView(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        category[0].name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
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
                          count != 0
                              ? MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: count,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 2),
                                        child: InkWell(
                                          child: SizedBox(
                                            height: 155,
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            category[0]
                                                                .courses![index]
                                                                .thumbanilFullPath!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      .5)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                                category[0]
                                                                    .courses![
                                                                        index]
                                                                    .title!,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none)),
                                                          ),
                                                          category[0]
                                                                      .courses![
                                                                          index]
                                                                      .freePremium ==
                                                                  1
                                                              ? SizedBox(
                                                                  height: 8,
                                                                )
                                                              : Container(),
                                                          category[0]
                                                                      .courses![
                                                                          index]
                                                                      .freePremium ==
                                                                  1
                                                              ? Icon(
                                                                  Icons
                                                                      .lock_rounded,
                                                                  size: 22,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              : Container()
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () => {
                                            Navigator.of(context)
                                                .push(CustomPageRoute(
                                                    child: CourseDetailsScreen(
                                              course:
                                                  category[0].courses![index],
                                            )))
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 160,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        'There is no Lesson available',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else {
                return Container();
              }
            });
  }

  Future<List<CoursesCategory>> fetchAllCourses() async {
    try {
      loading = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response =
          await Shared(context).get("categories/${widget.categoryId}");
      var jsonData = jsonDecode(response.body);

      category = (jsonData['category'] as List)
          .map((cat) => CoursesCategory.fromJson(cat))
          .toList();

      count = category[0].courses!.length;

      loading = false;

      return category;
    } on SocketException {
      Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(child: ConnectionLostScreen()), (_) => false);
      return category;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something Wrong, Please Try Again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return category;
    }
  }
}
