// ignore_for_file: prefer_const_constructors, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:robosoc/mainscreens/login_registerscreen/login_screen.dart';
import 'package:robosoc/mainscreens/navigatation_screen.dart';
import 'package:robosoc/mainscreens/startscreen/splash_screen1.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  SplashScreen1()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'ROBOTICS SOCIETY',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "NexaBold"),
          ),
          const Text(
            'NIT HAMIRPUR',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "NexaBold"),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/images/robotics_society_logo.png', width: 200),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Image.asset('assets/images/robotics_society_logo.png', width: 200),
          const SizedBox(height: 20),
          const Text(
            'Inventory Manager',
            style: TextStyle(fontSize: 22, fontFamily: "NexaRegular"),
          ),
        ],
      ),
    )));
  }
}
