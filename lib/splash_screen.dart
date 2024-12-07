import 'dart:async';
import 'package:flutter/material.dart';
import 'registration.dart';
import 'home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  var enable = CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
    changeEnable();
  }

  void changeEnable() {
    Timer(const Duration(seconds: 2), () {
      enable = CrossFadeState.showSecond;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedCrossFade(
      firstChild: Container(
        color: Colors.black,
      ),
      secondChild: SecondScreen(),
      crossFadeState: enable,
      duration: const Duration(seconds: 2),
    ));
  }
}

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondScreenState();
  }
}

class SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animate();
    store();
  }

  void animate() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  void store() async {
    var log = await SharedPreferences.getInstance();
    var val = log.getBool('log');
    if (val != null || val == true) {
      Timer(const Duration(seconds: 6), () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: Home(),
            type: PageTransitionType.leftToRight,
            duration:const Duration(milliseconds: 300),
          ),
        );
      });
    }
    else 
    {
        Timer(const Duration(seconds: 6), () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: userRegistration(),
              type: PageTransitionType.leftToRight,
              duration:const Duration(milliseconds: 300),
            ),
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "HH",
              style: TextStyle(
                fontSize: animation.value * 180,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Heading',
              ),
            ),
          ),
          Opacity(
            opacity: animation.value,
            child: const Text(
              "Headline Hub",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Heading',
              ),
            ),
          )
        ],
      ),
    );
  }
}
