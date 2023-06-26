// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:whiskers/loading.dart';
import 'package:whiskers/model/course.dart';
import 'package:whiskers/model/dog.dart';
import 'package:whiskers/screens/chewie.dart';
import 'package:whiskers/widget/app_style.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:whiskers/my-globals.dart' as globals;

import '../custom_page_route.dart';
import '../shared.dart';
import 'chat_with_us.dart';

class CourseDetailsScreen extends StatefulWidget {
  final Course course;
  const CourseDetailsScreen({
    Key? key,
    required this.course,
  }) : super(key: key);
  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool loading = false;
  bool compeleted = false;
  bool login = false;
  YoutubePlayerController _youtubeController =
      YoutubePlayerController(initialVideoId: '0');

  String videoname='';

  late Course course;
  List<Status> statusArr = [];
  Status? statusSelected;
  Dog? dogSelected = globals.currentDog;

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
    // _youtubeController = YoutubePlayerController(initialVideoId:YoutubePlayerController.convertUrlToId(widget.course.thumbanilFullPath!)!);
  }
   @override
  void dispose() {
    globals.chweiecontroller!.dispose();
    globals.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(19, 140, 237, 1)),
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
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.course.title!,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
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
          Container(
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(19, 140, 237, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  course.mainFileType != null && course.mainFile != null
                      ? course.mainFileType == 0
                          ? Container(
                              width: double.infinity,
                              height: 291,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(course.mainFile!),
                                      fit: BoxFit.fill)),
                            )
                          : course.mainFile!.endsWith('mp4')
                              ? SizedBox(
                                  height: 291,
                                  child: Chewie(
                                        controller:
                                            globals.chweiecontroller!)
                                )
                              : SizedBox(
                                  height: 291,
                                  child: YoutubePlayerControllerProvider(
                                    controller: _youtubeController,
                                    child: YoutubePlayerIFrame(
                                      controller: _youtubeController,
                                    ),
                                  ))
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            width: 65,
                          ),
                          Column(children: <Widget>[
                            const Text(
                              'DIFFICULTY',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 9),
                                    child: Image.asset(
                                        course.diffeculty! >= 1
                                            ? 'assets/images/difficultyBold.png'
                                            : 'assets/images/difficulty.png',
                                        width: 30),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 9),
                                    child: Image.asset(
                                        course.diffeculty! >= 2
                                            ? 'assets/images/difficultyBold.png'
                                            : 'assets/images/difficulty.png',
                                        width: 30),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 9),
                                    child: Image.asset(
                                        course.diffeculty! >= 3
                                            ? 'assets/images/difficultyBold.png'
                                            : 'assets/images/difficulty.png',
                                        width: 30),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 9),
                                    child: Image.asset(
                                        course.diffeculty! >= 4
                                            ? 'assets/images/difficultyBold.png'
                                            : 'assets/images/difficulty.png',
                                        width: 30),
                                  ),
                                  Image.asset(
                                      course.diffeculty! == 5
                                          ? 'assets/images/difficultyBold.png'
                                          : 'assets/images/difficulty.png',
                                      width: 30),
                                ]),
                          ]),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/images/badgeDetails.png',
                            alignment: Alignment.centerRight,
                            width: 48,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  const Text('STATUS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 142,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 242, 0, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: DropdownButton(
                          dropdownColor: Colors.white,
                          value: course.status,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: statusArr.map((Status status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status.name),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (Status? newValue) async {
                            setState(() {
                              course.status = newValue;
                            });
                            if (dogSelected != null &&
                                dogSelected!.id != 0) {
                              await Shared(context)
                                  .post("course/update-status", {
                                'status_id': (newValue!.id).toString(),
                                'dog_id': (dogSelected!.id).toString(),
                                'course_id': (course.id).toString()
                              });
                              Fluttertoast.showToast(
                                  msg: "Status Updated",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please Add Dog First",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(course.shortDescription!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 1.3)),
                  ),
                  course.freePremium == 0
                      ? Column(
                          children: [
                            course.steps!.isEmpty
                                ? Container()
                                : Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 21,
                                        ),
                                        const Text(
                                          'Steps',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  19, 140, 237, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        ListView.builder(
                                          itemCount: course.steps!.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, position) {
                                            return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 20),
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              CircleAvatar(
                                                                maxRadius:
                                                                    15,
                                                                backgroundColor:
                                                                    const Color.fromRGBO(
                                                                        19,
                                                                        140,
                                                                        237,
                                                                        1),
                                                                child: Text(
                                                                  (position +
                                                                          1)
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight.bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                80,
                                                            child: Html(
                                                              data: course
                                                                  .steps![
                                                                      position]
                                                                  .title,
                                                              style: {
                                                                "body":
                                                                    Style(
                                                                  fontSize:
                                                                      FontSize(
                                                                          16.0),
                                                                  color: Color.fromRGBO(
                                                                      111,
                                                                      112,
                                                                      116,
                                                                      1),
                                                                ),
                                                              },
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                  course.steps![position]
                                                              .fileType !=
                                                          null
                                                      ? SizedBox(
                                                          height: 20,
                                                        )
                                                      : Container(),
                                                  course.steps![position]
                                                              .fileType !=
                                                          null
                                                      ? course.steps![position]
                                                                  .fileType ==
                                                              0
                                                          ? Container(
                                                              height: 170,
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(course
                                                                          .steps![position]
                                                                          .file!),
                                                                      fit: BoxFit.cover)),
                                                            )
                                                          : SizedBox(
                                                              height: 170,
                                                              child: ChewieItem(
                                                                  videoPlayerController: VideoPlayerController.network(course
                                                                      .steps![
                                                                          position]
                                                                      .file!)),
                                                            )
                                                      : Container(),
                                                  course.steps![position]
                                                              .fileType !=
                                                          null
                                                      ? SizedBox(
                                                          height: 50,
                                                        )
                                                      : Container(),
                                                  position + 1 !=
                                                          course
                                                              .steps!.length
                                                      ? Container()
                                                      : SizedBox(
                                                          height: 30,
                                                        )
                                                ]);
                                          },
                                        ),
                                      ],
                                    )),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                color: course.tips!.isEmpty
                                    ? Color.fromRGBO(19, 140, 237, 1)
                                    : Color.fromRGBO(169, 58, 139, 1),
                                child: Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    course.tips!.isEmpty
                                        ? Container()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 34),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Tips',
                                                  textAlign:
                                                      TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                ListView.builder(
                                                  itemCount:
                                                      course.tips!.length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, position) {
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top:
                                                                        32),
                                                            child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    margin: const EdgeInsets.only(
                                                                        right:
                                                                            5,
                                                                        top:
                                                                            6),
                                                                    child:
                                                                        CircleAvatar(
                                                                      maxRadius:
                                                                          3,
                                                                      backgroundColor:
                                                                          Colors.white,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context).size.width -
                                                                        51,
                                                                    child: Text(
                                                                        course.tips![
                                                                            position],
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 18,
                                                                            height: 1.2)),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ]);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                    Container(
                                      height: 250,
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 30),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/courseDetailsBottom.png"),
                                              fit: BoxFit.fill)),
                                    )
                                  ],
                                )),
                          ],
                        )
                      : Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                              .size
                                              .width -
                                          110,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            'Sit  2.0 599.00 L.E.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Tricks include : scoot , jump rop, footstall ,rebound ,handstand',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.3))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 67,
                                      height: 32,
                                      child: ElevatedButton(
                                        child: const Text('Buy',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.bold)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              CustomPageRoute(
                                                  child:
                                                      const ChatWithUsScreen(
                                                          closIcon: true)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color.fromRGBO(
                                              19, 140, 237, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  color: AppThemeData().blueColor,
                                  height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                              .size
                                              .width -
                                          110,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            'All Lesson Packs  6,500,00 L.E.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Include All Current And Future Packs',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.3))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 67,
                                      height: 32,
                                      child: ElevatedButton(
                                        child: const Text('Buy',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.bold)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              CustomPageRoute(
                                                  child:
                                                      const ChatWithUsScreen(
                                                          closIcon: true)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color.fromRGBO(
                                              19, 140, 237, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 320,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  169, 58, 139, 1)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 34),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 20,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              'assets/images/Polygon.png'))),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .width,
                                                    child: const Text(
                                                      'Upgrade To Whiskers Premium!',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                  width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/courseDetailsDog.png",
                                                          width: 27,
                                                          height: 27,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Unlock All Current &Feature Lesson Packs',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14,
                                                                color: Colors
                                                                    .white,
                                                                height:
                                                                    1.3),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/courseDetailsDog.png",
                                                          width: 27,
                                                          height: 27,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Live Chat With Our Team To Get Your Trainning Questions Answered',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14,
                                                                color: Colors
                                                                    .white,
                                                                height:
                                                                    1.3),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                SizedBox(
                                                    height: 56,
                                                    width: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .width,
                                                    child: ElevatedButton(
                                                      child: const Text(
                                                          'LEARN MORE',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      onPressed: () {
                                                        Navigator.of(
                                                                context)
                                                            .push(CustomPageRoute(
                                                                child: const ChatWithUsScreen(
                                                                    closIcon:
                                                                        true)));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Color.fromRGBO(
                                                                19,
                                                                140,
                                                                237,
                                                                1),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      28),
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 50,
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
              )),
        ])));
  }

  fetchCourseDetails() async {
    try {
      loading = true;
      var response;
      if (dogSelected != null && dogSelected!.id != 0) {
        response = await Shared(context)
            .get("courses/${widget.course.id}/for-dog/${dogSelected!.id}");
      } else {
        response = await Shared(context).get("courses/${widget.course.id}");
      }
      var courseData = jsonDecode(response.body)['course'];

      course = Course.fromJson(courseData);

      //get All Status
      var responseStatus = await Shared(context).get("course-statuses");
      var statusData = jsonDecode(responseStatus.body)['coursesStatuses'];
      for (var i = 0; i < statusData.length; i++) {
        statusArr.add(Status.fromJson(statusData[i]));
      }

      if (courseData['status'] == null) {
        statusSelected = statusArr[0];
      }
      if (course.mainFileType == 1 && !course.mainFile!.endsWith('mp4')) {
        _youtubeController = YoutubePlayerController(
            initialVideoId:
                YoutubePlayerController.convertUrlToId(course.mainFile!)!);
      }
      if (course.mainFileType == 1 && course.mainFile!.endsWith('mp4')) {
        videoname = course.mainFile!;
        globals.controller = VideoPlayerController.network(videoname)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          });
        globals.chweiecontroller = ChewieController(
          videoPlayerController: globals.controller!,
          autoPlay: false,
          looping: false,
        );
      }

      setState(() {
        loading = false;
        statusArr = statusArr;
        statusSelected = statusSelected;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something Wrong, Please Try Again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
