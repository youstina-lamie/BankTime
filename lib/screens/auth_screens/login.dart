// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, null_check_always_fails, sized_box_for_whitespace, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:io';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:banktime/custom_page_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:banktime/loading.dart';
import 'package:banktime/model/dog.dart';
import 'package:banktime/screens/auth_screens/register.dart';
import 'package:banktime/screens/auth_screens/reset_password.dart';
import 'package:banktime/screens/questions_screens/clicker_intro.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import '../../bottom_navbar.dart';
import '../../shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  late bool visited;
  String dogs = '';

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FacebookAuth _facebookLogin = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Form(
                  key: loginFormKey,
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
                                  'Login',
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
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/Artboard – 1.png'))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(children: [
                            SizedBox(
                              height: 44,
                            ),
                            const Text('Add your details to login',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 37,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: email,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 27.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(19, 140, 237, 1)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: 'Your Email',
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(156, 156, 156, 1)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  isDense: true,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email required';
                                  } else if (!EmailValidator.validate(
                                      email.text)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 44,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: password,
                                obscureText: true,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromRGBO(156, 156, 156, 1),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 27.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                19, 140, 237, 1))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(19, 140, 237, 1)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromRGBO(156, 156, 156, 1)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 37,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 56,
                              child: ElevatedButton(
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  login();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(19, 140, 237, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Forgot your password?',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(CustomPageRoute(
                                                child:
                                                    const ResetPasswordScreen()));
                                      }),
                              ]),
                            ),
                            SizedBox(
                              height: 53,
                            ),
                            const Text('or Login With',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 29,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 56,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(54, 127, 192, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                onPressed: () {
                                  loginWithFaceBook();
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Login with Facebook",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 56,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(221, 75, 57, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                onPressed: () {
                                  loginWithGoogle();
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.googlePlusG,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            Platform.isIOS
                                ? SizedBox(
                                    height: 28,
                                  )
                                : Container(),
                            Platform.isIOS
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 56,
                                    child: SignInWithAppleButton(
                                      onPressed: () async {
                                        final credential = await SignInWithApple
                                            .getAppleIDCredential(
                                          scopes: [
                                            AppleIDAuthorizationScopes.email,
                                            AppleIDAuthorizationScopes.fullName,
                                          ],
                                        ).then((credential) async {
                                          setState(() {
                                            loading = true;
                                          });
                                          // var googleUser = _googleSignIn.currentUser;
                                          Response response =
                                              await Shared(context).postLogin(
                                                  "users/social-login",
                                                  jsonEncode({
                                                    'email': credential.email,
                                                    'name':
                                                        credential.givenName,
                                                    'provider_name': 'Apple'
                                                  }));
                                          var jsonResponse =
                                              json.decode(response.body);
                                          if (response.statusCode == 200) {
                                            if (jsonResponse['user'] != null) {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool('guest', false);
                                              prefs.setInt('userId',
                                                  jsonResponse['user']['id']);

                                              dogs = prefs.getString('dogs') ==
                                                      null
                                                  ? ''
                                                  : prefs.getString('dogs')!;

                                              if (dogs != '') {
                                                var jsonDog = json.decode(dogs);
                                                Dog dog =
                                                    Dog.fromJson(jsonDog[0]);

                                                Response responseAddDog =
                                                    await Shared(context)
                                                        .post("dogs/new", {
                                                  'name': dog.name,
                                                  'breed': (dog.breed!.id)
                                                      .toString(),
                                                  'gender': (dog.gender!.id)
                                                      .toString(),
                                                  'date_of_birth':
                                                      dog.birthDate.toString(),
                                                  'user_id':
                                                      (jsonResponse['user']
                                                              ['id'])
                                                          .toString()
                                                });
                                                prefs.remove('dogs');
                                              }

                                              visited =
                                                  prefs.getBool('visited') ==
                                                          null
                                                      ? false
                                                      : true;
                                              visited
                                                  ? Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          CustomPageRoute(
                                                              child: const Nav(
                                                            pageIndex: 0,
                                                          )),
                                                          (_) => false)
                                                  : Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pushAndRemoveUntil(
                                                          CustomPageRoute(
                                                              child:
                                                                  const ClickerIntro()),
                                                          (_) => false);
                                            } else {
                                              setState(() => loading = false);
                                              Fluttertoast.showToast(
                                                  msg: jsonResponse['error'],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          } else {}
                                        });

                                        print(credential);

                                        // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                                        // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                                      },
                                    ),
                                  )
                                : SizedBox.shrink(),
                            SizedBox(
                              height: 85,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("Don't have an Account? ",
                                    style: TextStyle(fontSize: 14)),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Sign Up',
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(19, 140, 237, 1),
                                            fontSize: 14),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushReplacement(CustomPageRoute(
                                                    child:
                                                        const RegisterScreen()));
                                          }),
                                  ]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 44,
                            )
                          ]),
                        ),
                      ),
                    ],
                  )),
            ));
  }

  login() async {
    try {
      if (loginFormKey.currentState!.validate()) {
        var jsonResponse;
        setState(() => loading = true);

        Response response = await Shared(context).postLogin("users/login",
            jsonEncode({'email': email.text, 'password': password.text}));

        if (response.statusCode == 200) {
          jsonResponse = jsonDecode(response.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('guest', false);
          prefs.setInt('userId', jsonResponse['user']['id']);

          dogs =
              prefs.getString('dogs') == null ? '' : prefs.getString('dogs')!;

          if (dogs != '') {
            var jsonDog = json.decode(dogs);
            Dog dog = Dog.fromJson(jsonDog[0]);

            Response responseAddDog = await Shared(context).post("dogs/new", {
              'name': dog.name,
              'breed': (dog.breed!.id).toString(),
              'gender': (dog.gender!.id).toString(),
              'date_of_birth': dog.birthDate.toString(),
              'user_id': (jsonResponse['user']['id']).toString()
            });
            prefs.remove('dogs');
          }

          visited = prefs.getBool('visited') == null ? false : true;
          visited
              ? Navigator.of(context).pushAndRemoveUntil(
                  CustomPageRoute(
                      child: const Nav(
                    pageIndex: 0,
                  )),
                  (_) => false)
              : Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  CustomPageRoute(child: const ClickerIntro()), (_) => false);
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Email or Password.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          setState(() => loading = false);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Invalid Email or Password",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<LoginResult> _handleSignInFacebook() async {
    try {
      _facebookLogin.logOut();

      final result = _facebookLogin.login();
      return result;
    } catch (error) {
      print(error);
      return null!;
    }
  }

  loginWithFaceBook() {
    setState(() {
      loading = true;
    });
    _handleSignInFacebook().then((result) async {
      switch (result.status) {
        case LoginStatus.success:
          final userData = await FacebookAuth.instance.getUserData();
          Response response = await Shared(context).postLogin(
              "users/social-login",
              jsonEncode({
                'email': userData['email'],
                'name': userData['name'],
                'provider_name': 'Facebook'
              }));
          var jsonResponse = json.decode(response.body);
          if (response.statusCode == 200) {
            if (jsonResponse['user'] != null) {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              prefs.setBool('guest', false);
              prefs.setInt('userId', jsonResponse['user']['id']);
              dogs = prefs.getString('dogs') == null
                  ? ''
                  : prefs.getString('dogs')!;
              if (dogs != '') {
                var jsonDog = json.decode(dogs);
                Dog dog = Dog.fromJson(jsonDog[0]);
                Response responseAddDog =
                    await Shared(context).post("dogs/new", {
                  'name': dog.name,
                  'breed': (dog.breed!.id).toString(),
                  'gender': (dog.gender!.id).toString(),
                  'date_of_birth': dog.birthDate.toString(),
                  'user_id': (jsonResponse['user']['id']).toString()
                });
                prefs.remove('dogs');
              }
              visited = prefs.getBool('visited') == null ? false : true;
              visited
                  ? Navigator.of(context).pushAndRemoveUntil(
                      CustomPageRoute(
                          child: const Nav(
                        pageIndex: 0,
                      )),
                      (_) => false)
                  : Navigator.of(context, rootNavigator: true)
                      .pushAndRemoveUntil(
                          CustomPageRoute(child: const ClickerIntro()),
                          (_) => false);
            } else {
              setState(() => loading = false);
              Fluttertoast.showToast(
                  msg: jsonResponse['error'],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {}

          break;
        case LoginStatus.cancelled:
          print(result.status);
          break;
        case LoginStatus.failed:
          print("result.errorMessage${result.message}");
          break;
        case LoginStatus.operationInProgress:
          print(result.status);
          break;
      }
    });
  }

  Future<GoogleSignInAuthentication> _handleSignInGoogle() async {
    {
      await _googleSignIn.signIn();
      return await _googleSignIn.currentUser!.authentication;
    }
  }

  loginWithGoogle() {
    _handleSignInGoogle().then((auth) async {
      setState(() => loading = false);
      var googleUser = _googleSignIn.currentUser;
      Response response = await Shared(context).postLogin(
          "users/social-login",
          jsonEncode({
            'email': googleUser!.email,
            'name': googleUser.displayName,
            'provider_name': 'Google'
          }));
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['user'] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('guest', false);
          prefs.setInt('userId', jsonResponse['user']['id']);
          dogs =
              prefs.getString('dogs') == null ? '' : prefs.getString('dogs')!;
          if (dogs != '') {
            var jsonDog = json.decode(dogs);
            Dog dog = Dog.fromJson(jsonDog[0]);
            Response responseAddDog = await Shared(context).post("dogs/new", {
              'name': dog.name,
              'breed': (dog.breed!.id).toString(),
              'gender': (dog.gender!.id).toString(),
              'date_of_birth': dog.birthDate.toString(),
              'user_id': (jsonResponse['user']['id']).toString()
            });
            prefs.remove('dogs');
          }

          visited = prefs.getBool('visited') == null ? false : true;
          visited
              ? Navigator.of(context).pushAndRemoveUntil(
                  CustomPageRoute(
                      child: const Nav(
                    pageIndex: 0,
                  )),
                  (_) => false)
              : Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  CustomPageRoute(child: const ClickerIntro()), (_) => false);
        } else {
          setState(() => loading = false);
          Fluttertoast.showToast(
              msg: jsonResponse['error'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    });
  }
}
