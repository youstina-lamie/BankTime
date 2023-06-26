// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/breed.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/model/gender.dart';
import 'package:banktime/screens/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../error_page.dart';
import '../../shared.dart';

class FirstQuestionScreen extends StatefulWidget {
  const FirstQuestionScreen({Key? key}) : super(key: key);
  @override
  _FirstQuestionScreenState createState() => _FirstQuestionScreenState();
}

class _FirstQuestionScreenState extends State<FirstQuestionScreen> {
  GlobalKey<FormState> addDogFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  Gender? genderSelected;
  Breed? breedselected;
  List<Gender> gendersArr = [];
  List<Breed> breedArr = [];
  bool loading = false;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    fetchGenderAndBreed();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: addDogFormKey,
                  child: Column(
                    children: [
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
                              // const SizedBox(
                              //   width: 40,
                              // ),
                              const Text(
                                'Hello!',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              // RichText(
                              //   text: TextSpan(children: [
                              //     TextSpan(
                              //         text: 'Next',
                              //         style: const TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 14,
                              //             decoration:
                              //                 TextDecoration.underline),
                              //         recognizer: TapGestureRecognizer()
                              //           ..onTap = () async {
                              //             Navigator.of(context)
                              //                 .pushReplacement(
                              //               CustomPageRoute(
                              //                   child:
                              //                       const WelcomeScreen()),
                              //             );
                              //           }),
                              //   ]),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/Artboard – 1.png'))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: const Color.fromRGBO(19, 140, 237, 1),
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/images/Mask Group 3.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                "Let's Start Traning",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "What Is Your Dog's Name?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: name,
                                  keyboardType: TextInputType.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1),
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromRGBO(156, 156, 156, 1)),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  "Breed",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                height: 19,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButtonFormField(
                                  value: breedselected,
                                  dropdownColor: Colors.white,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color.fromRGBO(19, 140, 237, 1),
                                  ),
                                  onTap: () => FocusScope.of(context).unfocus(),
                                  style: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1),
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Select Breed',
                                    hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Color.fromRGBO(156, 156, 156, 1)),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      value == null ? 'Breed Required' : null,
                                  items: breedArr.map((Breed item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item.breed),
                                    );
                                  }).toList(),
                                  onChanged: (Breed? newValue) {
                                    setState(() {
                                      breedselected = newValue!;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  "Date of Birth",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                height: 19,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: dateOfBirth,
                                  keyboardType: TextInputType.datetime,
                                  readOnly: true,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1),
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: 'Select Birth',
                                    hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Color.fromRGBO(156, 156, 156, 1)),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onTap: () async {
                                    final datePick = await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now());
                                    if (datePick != null) {
                                      setState(() {
                                        dateOfBirth.text =
                                            "${datePick.day}-${datePick.month}-${datePick.year}";
                                        selectedDate = datePick;
                                      });
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date of birth required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 41,
                              ),
                              Container(
                                width: 245,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(19, 140, 237, 1),
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          genderSelected = gendersArr[0];
                                        });
                                      },
                                      child: Container(
                                        width: 112,
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 7.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: genderSelected == gendersArr[0]
                                              ? const Color.fromRGBO(
                                                  255, 242, 0, 1)
                                              : const Color.fromRGBO(
                                                  19, 140, 237, 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(48.0)),
                                        ),
                                        child: Text(
                                          gendersArr[0].gender,
                                          style: TextStyle(
                                            color:
                                                genderSelected == gendersArr[0]
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          genderSelected = gendersArr[1];
                                        });
                                      },
                                      child: Container(
                                        width: 112,
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 7.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: genderSelected == gendersArr[1]
                                              ? const Color.fromRGBO(
                                                  255, 242, 0, 1)
                                              : const Color.fromRGBO(
                                                  19, 140, 237, 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(48.0)),
                                        ),
                                        child: Text(
                                          gendersArr[1].gender,
                                          style: TextStyle(
                                              color: genderSelected ==
                                                      gendersArr[1]
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              SizedBox(
                                width: 245,
                                height: 42,
                                child: ElevatedButton(
                                  child: const Text('Save',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    addDog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(19, 140, 237, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 47,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  fetchGenderAndBreed() async {
    try {
      loading = true;

      //fetch breeds
      var response = await Shared(context).get("breeds");
      var breedData = jsonDecode(response.body)['breeds'];
      for (var i = 0; i < breedData.length; i++) {
        breedArr.add(Breed.fromJson(breedData[i]));
      }

      //fetch gender
      var responseGender = await Shared(context).get("genders");
      var genderData = jsonDecode(responseGender.body)['genders'];
      for (var i = 0; i < genderData.length; i++) {
        gendersArr.add(Gender.fromJson(genderData[i]));
      }
      setState(() {
        gendersArr = gendersArr;
        breedArr = breedArr;
        genderSelected = gendersArr[0];
      });
      loading = false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Poor connection, Check your network Connection.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addDog() async {
    try {
      if (addDogFormKey.currentState!.validate()) {
        setState(() => loading = true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // delete Dog
        prefs.remove('dogs');

        Dog dog = Dog(
            id: null,
            name: name.text,
            birthDate: dateOfBirth.text,
            breed: breedselected!,
            gender: genderSelected!,
            userId: null);
        var dogsJson = [];
        dogsJson.add(dog.toJson());
        prefs.setString('dogs', json.encode(dogsJson));
        setState(() => loading = false);
        Navigator.of(context).push(CustomPageRoute(
            child: const WelcomeScreen(
          fromFirstQuestion: true,
        )));
      }
    } on SocketException {
      Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(child: const ConnectionLostScreen()), (_) => false);
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
