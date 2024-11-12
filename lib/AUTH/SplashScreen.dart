import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SIGNUPFRONTEND.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // Splash screen after 3 second..
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SIGNUPFRONTEND()));
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              color: Colors.white,
              "assets/images/yournode.png",
              height: 130,
              width: 200,
            ),
            const Center(
                child: Text(
              "Your Note",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ))
          ],
        ),
      ),
    );
  }
}
