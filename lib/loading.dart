import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: SpinKitWave(
          color: Color.fromRGBO(0, 80, 92, 1),
          size: 50.0,
        ),
      ),
    ));
  }
}
