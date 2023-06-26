// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:banktime/my-globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:banktime/bottom_navbar.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:banktime/error_page.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/breed.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/model/gender.dart';
import 'package:provider/provider.dart';

import '../../shared.dart';

class DogProfileEditScreen extends StatefulWidget {
  final Dog dog;
  // heeee
  final Function(Dog) callBack;

  const DogProfileEditScreen(
      {Key? key, required this.dog, required this.callBack})
      : super(key: key);

  @override
  _DogProfileEditScreenState createState() => _DogProfileEditScreenState();
}

class _DogProfileEditScreenState extends State<DogProfileEditScreen> {
  GlobalKey<FormState> editDogFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  late Gender genderSelected;
  late Breed breedselected;
  List<Gender> gendersArr = [];
  List<Breed> breedArr = [];
  bool loading = false;
  int? id;

  String birthDateInString = '';
  String imageDog = '';
  late DateTime birthDate;
  var jsonDog;
  String dateString = '';
  late Dog dog;
  File? image;
  XFile? imagePicker;

  @override
  void initState() {
    super.initState();
    fetchGenderAndBreed();
    getDogDetails();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: editDogFormKey,
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
                                'Edit Profile',
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
                                      : imageDog != ''
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              child: Image.network(
                                                imageDog,
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
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Change Photo',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(68, 68, 68, 1),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 31,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Name",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 9,
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
                                      vertical: 13, horizontal: 18),
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
                                  hintText: 'Type Name',
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
                            SizedBox(
                              height: 27,
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
                            SizedBox(
                              height: 9,
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
                                      vertical: 13, horizontal: 18),
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
                                  hintText: 'select breed',
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
                            SizedBox(
                              height: 27,
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
                            SizedBox(
                              height: 9,
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
                                      vertical: 13, horizontal: 18),
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
                                      initialDate: birthDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());
                                  if (datePick != null) {
                                    setState(() {
                                      birthDateInString = datePick.toString();

                                      dateOfBirth.text = birthDateInString;
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
                            SizedBox(
                              height: 30,
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
                            SizedBox(
                              height: 27,
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
                                  updateDog();
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
                            SizedBox(
                              height: 50,
                            ),
                            InkWell(
                              child: Text(
                                'Remove Dog',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(19, 140, 237, 1)),
                              ),
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: const Text(
                                      'Are you sure you want to delete your dog ? ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(height: 1.5),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              child: TextButton(
                                                onPressed: () =>
                                                    {deleteDog(jsonDog)},
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        19, 140, 237, 1),
                                              ),
                                            ),
                                          ])
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 50)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget bottomSheet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'Choose Profile Photo',
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Column(
                  children: const [Icon(Icons.camera), Text('Camera')],
                ),
                onTap: () {
                  pickImage(ImageSource.camera);
                },
              ),
              InkWell(
                child: Column(
                  children: const [Icon(Icons.image), Text('Gallery')],
                ),
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
              )
            ],
          )
        ],
      ),
    );
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

      // fetch breedSelected
      for (Breed breed in breedArr) {
        if (breed.id == jsonDog['breed']['id']) {
          breedselected = breed;
        }
      }
      // fetch genderSelected

      for (Gender gender in gendersArr) {
        if (gender.id == jsonDog['gender']['id']) {
          genderSelected = gender;
        }
      }
      setState(() {
        gendersArr = gendersArr;
        breedArr = breedArr;
        breedselected = breedselected;
        genderSelected = genderSelected;
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

  getDogDetails() async {
    dog = widget.dog;
    jsonDog = dog.toJson();
    name.text = jsonDog['name'];
    id = jsonDog['id'];
    if (jsonDog['image'] != null) {
      imageDog = jsonDog['image']['original_url'];
    }
    birthDate = DateTime.parse(jsonDog['date_of_birth']);

    dateString = (DateFormat('dd/MM/yyyy').format(birthDate)).toString();
    dateOfBirth.text = dateString;
  }

  deleteDog(dog) async {
    try {
      loading = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await Shared(context).delete("dogs/${jsonDog['id']}");
      // var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        loading = false;
        Navigator.of(context).pop();
        globals.currentDog = null;
        Provider.of<globals.DogSelectedProvider>(context, listen: false)
            .changeDogSelected(null);
        Navigator.of(context, rootNavigator: true)
            .pushReplacement(CustomPageRoute(
                child: const Nav(
          pageIndex: 3,
        )));
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

  updateDog() async {
    try {
      if (editDogFormKey.currentState!.validate()) {
        setState(() => loading = true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.getInt('userId');

        Dog editedDog = Dog(
            id: id,
            name: name.text,
            birthDate: birthDateInString,
            userId: userId,
            breed: breedselected,
            gender: genderSelected,
            image: ImageDog(originalUrl: imageDog));
        if (birthDateInString == '') {
          editedDog.birthDate = birthDate.toString();
        }
        var uri =
            Uri.parse('https://banktime.dev.wedev.sbs/api/dogs/${dog.id}');
        var request = http.MultipartRequest('POST', uri);
        request.fields["name"] = name.text;
        request.fields["breed_id"] = (breedselected.id).toString();
        request.fields["gender_id"] = (genderSelected.id).toString();
        request.fields["date_of_birth"] = (editedDog.birthDate).toString();
        request.fields["user_id"] = userId.toString();

        if (imagePicker != null) {
          var length = await imagePicker!.length();
          request.files.add(http.MultipartFile('dog_profile_image',
              imagePicker!.readAsBytes().asStream(), length,
              filename: imagePicker!.name));
        }
        var response = await request.send();
        final respStr = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          if (imagePicker != null) {
            var resJosn = jsonDecode(respStr);
            editedDog.image =
                ImageDog(originalUrl: resJosn['dog']['image']['original_url']);
          }

          Navigator.pop(context);
          // rootNavigator: true).pushReplacement(
          //   CustomPageRoute(
          //       child: Nav(
          //     pageIndex: 2,
          //   )),
          // hee
          widget.callBack(editedDog);

          Fluttertoast.showToast(
              msg: "Profile Updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
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
