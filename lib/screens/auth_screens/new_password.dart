import 'package:flutter/material.dart';
import 'package:whiskers/bottom_navbar.dart';
import 'package:whiskers/custom_page_route.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: 
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Column(
                  children: [
                    const Text('New Password',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text('Please enter your email to receive a link to create a new password via email',textAlign:TextAlign.center,style: TextStyle(fontSize: 14))
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50,bottom: 30),

                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    child:TextField(
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Color.fromRGBO(156, 156, 156, 1), fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 30,right: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(255, 202, 0, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'New Password',
                        hintStyle: const TextStyle(color: Color.fromRGBO(156, 156, 156, 1)),
                        filled: true,
                        fillColor: const Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),

                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    child:TextField(
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Color.fromRGBO(156, 156, 156, 1), fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 30,right: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(255, 202, 0, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(color: Color.fromRGBO(156, 156, 156, 1)),
                        filled: true,
                        fillColor: const Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text('Next',style:
                      TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    onPressed: () {
                      Navigator.of(context).push(CustomPageRoute(child: const Nav(pageIndex: 0,)));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(255, 202, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                
                
              ]
            ),
          ),
        
      )
    );
  }
}
