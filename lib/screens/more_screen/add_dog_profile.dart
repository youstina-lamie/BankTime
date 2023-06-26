// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, nullable_type_in_catch_clause

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banktime/bottom_navbar.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/breed.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/model/gender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../error_page.dart';
import '../../shared.dart';
import 'package:banktime/my-globals.dart' as globals;

class AddDogProfileScreen extends StatefulWidget {
  const AddDogProfileScreen({Key? key}) : super(key: key);
  @override
  _AddDogProfileScreenState createState() => _AddDogProfileScreenState();
}

class _AddDogProfileScreenState extends State<AddDogProfileScreen> {
  GlobalKey<FormState> addDogFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  Gender? genderSelected;
  Breed? breedselected;
  List<Gender> gendersArr = [];
  List<Breed> breedArr = [];
  bool loading = false;
  DateTime selectedDate = DateTime.now();
  File? image;
  late XFile? imagePicker;

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
            body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: addDogFormKey,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(19, 140, 237, 1)),
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
                              const Text(
                                'Add Dog Profile',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                            Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color:
                                        const Color.fromRGBO(19, 140, 237, 1),
                                  ),
                                  child: image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          child: Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                          ))
                                      : Image.asset(
                                          'assets/images/Mask Group 3.png'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 15,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      onTap: () {
                                        pickImage(ImageSource.gallery);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Upload Dog Profile',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(68, 68, 68, 1),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  "Let's Start Traning",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3),
                                  textAlign: TextAlign.center,
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "What Is Your Dog's Name?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
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
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(19, 140, 237, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
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
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(19, 140, 237, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: 'Select Breed',
                                  hintStyle: const TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
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
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(19, 140, 237, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: 'Select Birth',
                                  hintStyle: const TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(156, 156, 156, 1)),
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
                                          color: genderSelected == gendersArr[0]
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
                                            color:
                                                genderSelected == gendersArr[1]
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
                              height: 50,
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
  }

  Future pickImage(ImageSource source) async {
    try {
      imagePicker = await ImagePicker().pickImage(
        source: source,
      );

      if (imagePicker == null) return;
      final imageTemporary = File(imagePicker!.path);
      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  addDog() async {
    try {
      if (addDogFormKey.currentState!.validate()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.getInt('userId');

        if (image == null) {
          Fluttertoast.showToast(
              msg: "Please Select Dog Image.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          setState(() => loading = true);
          var length = await imagePicker!.length();
          var uri = Uri.parse('https://banktime.dev.wedev.sbs/api/dogs/new');
          var request = http.MultipartRequest('POST', uri);
          request.fields["name"] = name.text;
          request.fields["breed"] = (breedselected?.id).toString();
          request.fields["gender"] = (genderSelected?.id).toString();
          request.fields["date_of_birth"] = dateOfBirth.text;
          request.fields["user_id"] = userId.toString();
          request.files.add(http.MultipartFile('dog_profile_image',
              imagePicker!.readAsBytes().asStream(), length,
              filename: imagePicker!.name));
          var response = await request.send();

          if (response.statusCode == 200) {
            final respStr = await response.stream.bytesToString();
            var resJosn = jsonDecode(respStr);
            Dog newDog = Dog.fromJson(resJosn['dog']);
            newDog.gender = genderSelected;
            newDog.breed = breedselected;
            globals.currentDog = newDog;
            Provider.of<globals.DogSelectedProvider>(context, listen: false)
                .changeDogSelected(newDog);
            Navigator.of(context, rootNavigator: true).pushReplacement(
                CustomPageRoute(child: const Nav(pageIndex: 3)));
          } else {
            setState(() => loading = false);
            Fluttertoast.showToast(
                msg: "Poor connection, Check your network Connection.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          // setState(() => loading = true);
          // Response response = await Shared(context).post("dogs/new", {
          //   'name': name.text,
          //   'breed': (breedselected?.id).toString(),
          //   'gender': (genderSelected?.id).toString(),
          //   'date_of_birth': dateOfBirth.text,
          //   'user_id': userId.toString()
          // });
          // if (response.statusCode == 200) {
          //   name.text = '';
          //   dateOfBirth.text = '';
          //   genderSelected = null;
          //   breedselected = null;
          //   setState(() => loading = false);
          //   if (widget.fromFooter) {
          //     Navigator.of(context).pushReplacement(CustomPageRoute(
          //         child: const Nav(
          //       pageIndex: 1,
          //     )));
          //   } else {
          //     Navigator.of(context).pushReplacement(CustomPageRoute(
          //         child: const DogsListingScreen(fromAdd: true)));
          //   }
          // } else {
          //   setState(() => loading = false);
          //   Fluttertoast.showToast(
          //   msg: "Poor connection, Check your network Connection.",
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0
          // );
        }
      }
    } on SocketException {
      Navigator.of(context).pushAndRemoveUntil(
          CustomPageRoute(child: const ConnectionLostScreen()), (_) => false);
    } catch (e) {
      print("add dog screen$e");
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
