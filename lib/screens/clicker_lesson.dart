// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:banktime/bottom_navbar.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/course.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:banktime/my-globals.dart' as globals;
import 'package:banktime/screens/chewie.dart';
import 'package:banktime/widget/app_style.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../shared.dart';

class ClickerLesson extends StatefulWidget {
  final fromIntro;
  const ClickerLesson({Key? key, required this.fromIntro}) : super(key: key);
  @override
  _ClickerLessonState createState() => _ClickerLessonState();
}

class _ClickerLessonState extends State<ClickerLesson> {
  bool loading = false;
  late Course course;
  String videoname = '';
  bool login = false;
  String dropdownvalue = 'Item 1';
  YoutubePlayerController _youtubeController =
      YoutubePlayerController(initialVideoId: '0');

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
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
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60, bottom: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
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
                    Text(
                      'Clicker Intro',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    widget.fromIntro
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Done',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushAndRemoveUntil(
                                              CustomPageRoute(
                                                  child: const Nav(
                                                pageIndex: 0,
                                              )),
                                              (_) => false);
                                    }),
                            ]),
                          )
                        : SizedBox(
                            width: 20,
                          )
                  ],
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromRGBO(19, 140, 237, 1),
                child: Column(
                  children: <Widget>[
                    course.mainFileType != null && course.mainFile != null
                        ? course.mainFileType == 0
                            ? Container(
                                width: double.infinity,
                                height: 221,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(course.mainFile!),
                                        fit: BoxFit.fill)),
                              )
                            : course.mainFile!.endsWith('mp4')
                                ? SizedBox(
                                    height: 221,
                                    child: Chewie(
                                        controller: globals.chweiecontroller!),
                                  )
                                : SizedBox(
                                    height: 221,
                                    child: YoutubePlayerControllerProvider(
                                      controller: _youtubeController,
                                      child: YoutubePlayerIFrame(
                                        controller: _youtubeController,
                                      ),
                                    ))
                        : Container(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(course.shortDescription!,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18, height: 1.5)),
                    ),
                    Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Steps',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(19, 140, 237, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 24),
                              ListView.builder(
                                itemCount: course.steps!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, position) {
                                  return Column(children: <Widget>[
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CircleAvatar(
                                                maxRadius: 15,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        19, 140, 237, 1),
                                                child: Text(
                                                  (position + 1).toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                86,
                                            child: Html(
                                              data:
                                                  course.steps![position].title,
                                              style: {
                                                "body": Style(
                                                  fontSize: FontSize(16.0),
                                                  color: Color.fromRGBO(
                                                      111, 112, 116, 1),
                                                ),
                                              },
                                            ),
                                          ),
                                        ]),
                                    course.steps![position].fileType != null
                                        ? SizedBox(
                                            height: 20,
                                          )
                                        : Container(),
                                    course.steps![position].fileType != null
                                        ? course.steps![position].fileType == 0
                                            ? Container(
                                                height: 150,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            course
                                                                .steps![
                                                                    position]
                                                                .file!),
                                                        fit: BoxFit.fill)),
                                              )
                                            : SizedBox(
                                                height: 170,
                                                child: ChewieItem(
                                                    videoPlayerController:
                                                        VideoPlayerController
                                                            .network(course
                                                                .steps![
                                                                    position]
                                                                .file!)),
                                              )
                                        : Container(),
                                    course.steps![position].fileType != null
                                        ? SizedBox(
                                            height: 20,
                                          )
                                        : Container(),
                                    position + 1 != course.steps!.length
                                        ? Divider(
                                            color: AppThemeData().blueColor,
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ]);
                                },
                              ),
                            ],
                          ),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromRGBO(169, 58, 139, 1),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 34),
                              child: Column(
                                children: [
                                  Text(
                                    'Tips',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ListView.builder(
                                    itemCount: course.tips!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, position) {
                                      return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 32),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5, top: 6),
                                                      child: CircleAvatar(
                                                        maxRadius: 3,
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              51,
                                                      child: Text(
                                                          course
                                                              .tips![position],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                            SizedBox(
                              height: 34,
                            ),
                            Container(
                              height: 207,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/courseDetailsBottom.png"),
                                      fit: BoxFit.fill)),
                            )
                          ],
                        )),
                  ],
                )),
          ])));
  }

  fetchCourseDetails() async {
    try {
      loading = true;
      var response = await Shared(context).get("courses/28");
      var courseData = jsonDecode(response.body)['course'];
      course = Course.fromJson(courseData);
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
