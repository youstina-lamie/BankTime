import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:whiskers/custom_page_route.dart';
import 'package:whiskers/loading.dart';
import 'package:whiskers/model/courses_category.dart';
import 'package:whiskers/screens/courses_listing.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../error_page.dart';
import '../shared.dart';

class FreeLessonsScreen extends StatefulWidget {
  const FreeLessonsScreen({Key? key}) : super(key: key);
  @override
  _FreeLessonsScreenState createState() => _FreeLessonsScreenState();
}

class _FreeLessonsScreenState extends State<FreeLessonsScreen> {
  List<CoursesCategory> categories = [];
  List<CoursesCategory> categoriesTemp = [];
  String searchString = "";

  var count = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //               decoration: const BoxDecoration(color: Colors.white),
          //               child: SizedBox(
          //                 width: double.infinity,
          //                 height: 60,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(10),
          //                   child: TextField(
          //                     controller: searchController,
          //                     textAlign: TextAlign.left,
          //                     style: const TextStyle(
          //                         color: Color.fromRGBO(156, 156, 156, 1),
          //                         fontSize: 14),
          //                     decoration: InputDecoration(
          //                       prefixIcon: const Icon(Icons.search),
          //                       contentPadding:
          //                           const EdgeInsets.only(left: 30, right: 30),
          //                       border: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(20),
          //                           borderSide: BorderSide.none),
          //                       focusedBorder: OutlineInputBorder(
          //                         borderSide: const BorderSide(
          //                             color: Color.fromRGBO(255, 202, 0, 1)),
          //                         borderRadius: BorderRadius.circular(20),
          //                       ),
          //                       hintText: 'Search for training courses',
          //                       hintStyle: const TextStyle(
          //                           color: Color.fromRGBO(156, 156, 156, 1)),
          //                       filled: true,
          //                       fillColor:
          //                           const Color.fromRGBO(242, 242, 242, 1),
          //                     ),
          //                     onChanged: (value) {
          //                       setState(() {
          //                         searchString = value;
          //                       });
          //                       // List searchedCategoryJson = [];
          //                       // List CategoriesList = categories.map((e) => e.toJson()).toList();
          //                       // if (value != '') {
          //                       //   for (var cat in CategoriesList) {
          //                       //     if (cat['name'].contains(value)) {
          //                       //       searchedCategoryJson.add(cat);
          //                       //     }
          //                       //   }
          //                       //   print('wsl hnaaaaaaaaaaa');
          //                       //   print(searchedCategoryJson.runtimeType);
          //                       //   print(categories.runtimeType);
          //                       //   var a = json.encode(searchedCategoryJson);
          //                       //   var jsonData = jsonDecode(a);
          //                       //   print(a.runtimeType);

          //                       //   categories = (jsonData as List)
          //                       //       .map((category) =>
          //                       //           CoursesCategory.fromJson(category))
          //                       //       .toList();
          //                       //   print(categories);
          //                       // } else {
          //                       //   print('fady');
          //                       //   categories = categoriesTemp;
          //                       // }
          //                       // setState(() {
          //                       //   categories = categories;
          //                       // });
          //                     },
          //                   ),
          //                 ),
          //               ),
          //             ),

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
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (context, index) {
                            CoursesCategory category =
                                (snapshot.data as List)[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              child: InkWell(
                                child: SizedBox(
                                  height: 155,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  category.imageFullPath),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            decoration: const BoxDecoration(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, .5)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(category.name,
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => {
                                  Navigator.of(context).push(CustomPageRoute(
                                      child: CoursesListingScreen(
                                    categoryId: category.id,
                                  )))
                                },
                              ),
                            );
                          },
                        ),
                      );
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
      Response response = await Shared(context).get("categories/for/0");
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
        fontSize: 16.0
      );
     
      return categories;
    }
  }
}
