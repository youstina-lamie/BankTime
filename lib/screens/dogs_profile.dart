// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/error_page.dart';
import 'package:banktime/model/breed.dart';
import 'package:banktime/model/course.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/model/gender.dart';
import 'package:banktime/my-globals.dart' as globals;
import 'package:banktime/screens/more.dart';
import 'package:banktime/screens/more_screen/add_dog_profile.dart';

import '../../loading.dart';
import '../../shared.dart';
import 'more_screen/dog_profile_edit.dart';

class DogsProfileScreen extends StatefulWidget {
  const DogsProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DogsProfileScreenState createState() => _DogsProfileScreenState();
}

class _DogsProfileScreenState extends State<DogsProfileScreen> {
  int sortedBySelectedIndex = 0;
  bool loading = false;
  int index = 0;

  List<Dog> dogsListing = [];
  List<Course> coursesForDog = [];
  List<Status> statusArr = [];
  Status? statusSelected;
  Future<List<Dog>>? getDogs;
  int startedCourse = 0;

  Dog dog = Dog(
      id: 0,
      userId: 0,
      birthDate: DateTime.now().toString(),
      name: 'Add New Dog',
      gender: Gender(id: 1, gender: 'Male'),
      breed: Breed(id: 6, breed: 'Beagle'));

  Dog? dogSelected;
  var count = 0;

  @override
  void initState() {
    super.initState();

    getDogs = fetchDogs();
  }

  @override
  Widget build(BuildContext context) {
    Dog? dogSelectedPro =
        Provider.of<globals.DogSelectedProvider>(context).dogSelectedProvider;
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: fetchDogs,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: getDogs,
                        builder: (ctx, AsyncSnapshot<List<Dog>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
                              if (count != 1) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(
                                              255, 18, 101, 114)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 60,
                                            bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<Dog>(
                                                  value: dogSelected,
                                                  customButton: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        dogSelected!.name,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )
                                                    ],
                                                  ),
                                                  items: dogsListing
                                                      .map((Dog lst) {
                                                    return DropdownMenuItem<
                                                            Dog>(
                                                        value: lst,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration: (lst
                                                                      .name ==
                                                                  'Add New Dog')
                                                              ? const BoxDecoration()
                                                              : const BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          width:
                                                                              1.0,
                                                                          color: Color.fromRGBO(
                                                                              19,
                                                                              140,
                                                                              237,
                                                                              1)))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        19,
                                                                    vertical:
                                                                        6),
                                                            child: Row(
                                                              children: [
                                                                (lst.name ==
                                                                        'Add New Dog')
                                                                    ? const Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Color.fromRGBO(
                                                                            19,
                                                                            140,
                                                                            237,
                                                                            1),
                                                                        size:
                                                                            25,
                                                                      )
                                                                    : Image.asset(
                                                                        'assets/images/dog_icon.png'),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  lst.name,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                                  }).toList(),
                                                  onChanged: (value) async {
                                                    if (value!.name ==
                                                        "Add New Dog") {
                                                      Navigator.of(context)
                                                          .push(CustomPageRoute(
                                                              child:
                                                                  const AddDogProfileScreen()));
                                                    } else {
                                                      setState(() {
                                                        loading = true;
                                                        var _newSelectedDog =
                                                            value;
                                                        dogSelected =
                                                            _newSelectedDog;
                                                        globals.currentDog =
                                                            dogSelected;
                                                        dogSelectedPro =
                                                            dogSelected;
                                                      });
                                                      Provider.of<
                                                                  globals
                                                                      .DogSelectedProvider>(
                                                              context,
                                                              listen: false)
                                                          .changeDogSelected(
                                                              dogSelectedPro!);

                                                      await fetchDogs();
                                                    }
                                                  },
                                                  dropdownPadding:
                                                      const EdgeInsets.all(0),
                                                  itemPadding:
                                                      const EdgeInsets.all(0),
                                                  itemHeight: 50,
                                                  dropdownWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Colors.white,
                                                  ),
                                                  dropdownElevation: 8,
                                                  offset: const Offset(0, 8),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              child: const Icon(
                                                Icons.settings,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    CustomPageRoute(
                                                        child:
                                                            const MoreScreen()));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 180,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                169, 58, 139, 1)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 90,
                                              margin: const EdgeInsets.only(
                                                  bottom: 15),
                                              decoration: dogSelected!.image !=
                                                          null &&
                                                      dogSelected!.image!
                                                              .originalUrl !=
                                                          ''
                                                  ? BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 3.0,
                                                          color: Colors.white))
                                                  : const BoxDecoration(),
                                              child: dogSelected!.image !=
                                                          null &&
                                                      dogSelected!.image!
                                                              .originalUrl !=
                                                          ''
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90),
                                                      child: Image.network(
                                                        dogSelected!
                                                            .image!.originalUrl,
                                                        fit: BoxFit.cover,
                                                      ))
                                                  : Image.asset(
                                                      'assets/images/dogProfile.png'),
                                            ),
                                            InkWell(
                                              child: const Text(
                                                'Edit Info',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    CustomPageRoute(
                                                        child:
                                                            DogProfileEditScreen(
                                                  dog: dogSelected!,
                                                  callBack: (dog) {
                                                    globals.currentDog = dog;
                                                    dogSelectedPro = dog;
                                                    Provider.of<
                                                                globals
                                                                    .DogSelectedProvider>(
                                                            context,
                                                            listen: false)
                                                        .changeDogSelected(dog);

                                                    dogsListing[
                                                            dogsListing.indexOf(
                                                                dogSelected!)] =
                                                        dog;
                                                    dogSelected = dog;
                                                    setState(() {});
                                                  },
                                                )));
                                              },
                                            )
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Training Progress',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '$startedCourse / ${coursesForDog.length}',
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Color.fromRGBO(
                                                        19, 140, 237, 1),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              child: const Text(
                                                'Total Mastered Tricks:',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                                textAlign: TextAlign.left,
                                              )),
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5, top: 15),
                                              child: const Text(
                                                'Sort By:',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              )),
                                          ToggleSwitch(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.4,
                                            minHeight: 37,
                                            fontSize: 14.0,
                                            initialLabelIndex: 0,
                                            activeBgColor: [
                                              const Color.fromRGBO(
                                                  19, 140, 237, 1)
                                            ],
                                            activeFgColor: Colors.white,
                                            inactiveBgColor: Colors.white,
                                            borderWidth: 1.0,
                                            borderColor: [
                                              const Color.fromRGBO(
                                                  19, 140, 237, 1)
                                            ],
                                            inactiveFgColor:
                                                const Color.fromRGBO(
                                                    19, 140, 237, 1),
                                            totalSwitches: 3,
                                            dividerColor: const Color.fromRGBO(
                                                19, 140, 237, 1),
                                            labels: [
                                              dogSelected!.name,
                                              'Difficulty',
                                              'Status'
                                            ],
                                            onToggle: (i) {
                                              // if (i != index) {
                                              //   setState(() {
                                              //     index == i;
                                              //     loading = true;
                                              //   });
                                              //   if (i == 0) {
                                              //     fetchCourses();
                                              //   } else if (i == 2) {
                                              //     coursesForDog.sort(
                                              //         (a, b) => a
                                              //             .diffeculty!
                                              //             .compareTo(b
                                              //                 .diffeculty!));
                                              //     setState(() {
                                              //       coursesForDog =
                                              //           coursesForDog;
                                              //     });
                                              //   } else {
                                              //     coursesForDog.sort(
                                              //         (a, b) => a
                                              //             .status!.id
                                              //             .compareTo(b
                                              //                 .status!.id));
                                              //     setState(() {
                                              //       coursesForDog =
                                              //           coursesForDog;
                                              //     });
                                              //   }
                                              //   setState(() {
                                              //     loading = false;
                                              //   });
                                              // }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: coursesForDog.length + 1,
                                        itemBuilder: (context, index) {
                                          return coursesForDog.length != index
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    19,
                                                                    140,
                                                                    237,
                                                                    1)),
                                                      ),
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                                  child: coursesForDog[index]
                                                                              .freePremium ==
                                                                          1
                                                                      ? Icon(
                                                                          Icons
                                                                              .lock_rounded,
                                                                          color:
                                                                              Colors.grey[400],
                                                                          size:
                                                                              22,
                                                                        )
                                                                      : Container(),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    coursesForDog[
                                                                            index]
                                                                        .title!,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          SizedBox(
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton<
                                                                      Status>(
                                                                dropdownColor:
                                                                    Colors
                                                                        .white,
                                                                value:
                                                                    coursesForDog[
                                                                            index]
                                                                        .status,
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_right_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                style: const TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            185,
                                                                            185,
                                                                            185,
                                                                            1),
                                                                    fontSize:
                                                                        14),
                                                                items: statusArr
                                                                    .map((Status
                                                                        status) {
                                                                  return DropdownMenuItem<
                                                                      Status>(
                                                                    value:
                                                                        status,
                                                                    child: Text(
                                                                        status
                                                                            .name),
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (value) async {
                                                                  if (value !=
                                                                      coursesForDog[
                                                                              index]
                                                                          .status) {
                                                                    if (value!
                                                                            .id ==
                                                                        1) {
                                                                      startedCourse -=
                                                                          1;
                                                                    }
                                                                    if (value.id !=
                                                                            1 &&
                                                                        coursesForDog[index].status!.id ==
                                                                            1) {
                                                                      startedCourse +=
                                                                          1;
                                                                    }
                                                                    setState(
                                                                        () {
                                                                      startedCourse =
                                                                          startedCourse;
                                                                      coursesForDog[index]
                                                                              .status =
                                                                          value;
                                                                    });
                                                                    await Shared(
                                                                            context)
                                                                        .post(
                                                                            "course/update-status",
                                                                            {
                                                                          'status_id':
                                                                              (value.id).toString(),
                                                                          'dog_id':
                                                                              (dogSelected!.id).toString(),
                                                                          'course_id':
                                                                              (coursesForDog[index].id).toString()
                                                                        });
                                                                    Fluttertoast.showToast(
                                                                        msg:
                                                                            "Status Updated",
                                                                        toastLength:
                                                                            Toast
                                                                                .LENGTH_SHORT,
                                                                        gravity:
                                                                            ToastGravity
                                                                                .BOTTOM,
                                                                        timeInSecForIosWeb:
                                                                            1,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .green,
                                                                        textColor:
                                                                            Colors
                                                                                .white,
                                                                        fontSize:
                                                                            16.0);
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                  ))
                                              : const SizedBox(
                                                  height: 50,
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 17,
                                              bottom: 17),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Container()),
                                              InkWell(
                                                child: const Icon(
                                                  Icons.settings,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      CustomPageRoute(
                                                          child:
                                                              const MoreScreen()));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                140,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'You Have No Dogs',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 60),
                                              width: 220,
                                              height: 50,
                                              child: ElevatedButton(
                                                child: const Text('Add Dog',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      CustomPageRoute(
                                                          child:
                                                              const AddDogProfileScreen()));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          19, 140, 237, 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]);
                              }
                            } else {
                              return Container();
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const Loading(),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ],
                ),
              ),
            ));
  }

  Future<List<Dog>> fetchDogs() async {
    try {
      startedCourse = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('userId')!;

      Response response = await Shared(context).get("dogs/for-user/$userId");
      var jsonData = jsonDecode(response.body);

      dogsListing =
          (jsonData['Dogs'] as List).map((dog) => Dog.fromJson(dog)).toList();
      if (!dogsListing.contains(dog)) {
        dogsListing.add(dog);
      }

      count = dogsListing.length;

      if (count != 1) {
        //get All Status
        var responseStatus = await Shared(context).get("course-statuses");

        List<Status> statusData =
            ((jsonDecode(responseStatus.body)['coursesStatuses']) as List)
                .map<Status>((dynamic i) => Status.fromJson(i))
                .toList();
        statusArr = statusData;

        if (globals.currentDog == null) {
          dogSelected = dogsListing[0];
          globals.currentDog = dogSelected!;
        } else {
          dogSelected = globals.currentDog;
        }

        coursesForDog.clear();

        Response coursesResponse =
            await Shared(context).get("courses/for-dog/${dogSelected!.id}");
        var coursesjson = jsonDecode(coursesResponse.body);

        coursesForDog = (coursesjson['courses'] as List)
            .map((course) => Course.fromJson(course))
            .toList();

        for (Course c in coursesForDog) {
          if (c.status!.id == 2 || c.status!.id == 3) {
            startedCourse += 1;
          }
        }
        setState(() {
          loading = false;
          startedCourse = startedCourse;
        });
      }

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

  fetchCourses() async {
    coursesForDog.clear();

    Response coursesResponse =
        await Shared(context).get("courses/for-dog/${dogSelected!.id}");
    var coursesjson = jsonDecode(coursesResponse.body);

    coursesForDog = (coursesjson['courses'] as List)
        .map((course) => Course.fromJson(course))
        .toList();
    setState(() {
      coursesForDog = coursesForDog;
    });
  }
}
