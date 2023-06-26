import 'package:flutter/material.dart';
import 'package:whiskers/bottom_navbar.dart';

import 'custom_page_route.dart';

class ConnectionLostScreen extends StatelessWidget {
  const ConnectionLostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/10_Connection Lost.png",
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.12,
              left: MediaQuery.of(context).size.width * 0.065,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 25,
                      color: const Color(0xFF59618B).withOpacity(0.17),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  child: const Text(
                    'Go To Home Page',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(child: const Nav(pageIndex: 0,)), (_) => false);
       
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(255, 202, 0, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
