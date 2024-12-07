import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';

class loginUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginUserState();
  }
}

class loginUserState extends State<loginUser> {
  var time = true;

  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      time = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: time
          ? Container(
              color: Colors.blue.shade300,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.blue,
                  strokeWidth: 5,
                ),
              ),
            )
          : Stack(
              children: [
                Image.asset(
                  'assets/Image/bg.jpg',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Headline Hub",
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Heading',
                          ),
                        ),
                        const Text(
                          "Login Now",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        textFileds(),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class textFileds extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return textFiledsState();
  }
}

class textFiledsState extends State<textFileds> {
  var visibility = const Icon(
    Icons.visibility,
    color: Colors.white,
  );
  var show = true;
  var uName = TextEditingController();
  var uPassword = TextEditingController();
  var preName = '';
  var preEmail = '';
  var prePassword = '';

  var errName = null;
  var errPassword = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container( // Text Filead for the User Name
          width: double.infinity,
          padding: EdgeInsets.only(top: 30, right: 30, left: 30),
          child: TextField(
            keyboardType: TextInputType.name,
            controller: uName,
            style: TextStyle(color: Colors.white),
            cursorErrorColor: Colors.red,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                error: errName,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 3,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 3,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 3,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    )),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                labelText: 'User Name',
                labelStyle: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
        Container( // Text Filead for the Password
          width: double.infinity,
          padding: EdgeInsets.only(top: 30, right: 30, left: 30),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            controller: uPassword,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            obscureText: show,
            decoration: InputDecoration(
                error: errPassword,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 3,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 3,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 3,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    )),
                prefixIcon: const Icon(
                  Icons.password_outlined,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (show) {
                      show = false;
                      visibility =
                          Icon(Icons.visibility_off, color: Colors.white);
                    } else {
                      show = true;
                      visibility = Icon(Icons.visibility, color: Colors.white);
                    }
                    setState(() {});
                  },
                  icon: visibility,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 30, right: 80, left: 80),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 3)),
          child: TextButton(
            onPressed: () {
              check();
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )
      ],
    );
  }

  void check() { // Function check user enter data is true or not 
    if (uName.text != '' && uPassword.text != '') {
      validate();
    } else {
      // Validate User Name.
      if (uName.text == '') {
        errName = const Text(
          "Please enter the name.",
          style: TextStyle(
              fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
        );
        setState(() {});
      } else {
        errName = null;
        setState(() {});
      }

      // Validate User Password.
      if (uPassword.text == '') {
        errPassword = const Text(
          "Please enter the Password.",
          style: TextStyle(
              fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
        );
        setState(() {});
      } else {
        errPassword = null;
        setState(() {});
      }
    }
  }

  void validate() async { // Function for checking the Registration Data and Login Data
    var pref = await SharedPreferences.getInstance();
    preName = pref.getString('name').toString();
    prePassword = pref.getString('pass').toString();
    if (uName.text.compareTo(preName) == 0) {
        if ((uPassword.text.toString()).compareTo(prePassword) == 0) {
          store();
          Navigator.pushReplacement(
              context,
              PageTransition(
                child: Home(),
                type: PageTransitionType.leftToRight,
                duration: const Duration(milliseconds: 300),
              ));
        } else {
          errPassword = const Text(
            "Password does't match.",
            style: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
          );
          setState(() {});
        }
      } else {
        errName = const Text(
          "Name Does't Exists.",
          style: TextStyle(
              fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
        );
        setState(() {});
      }
  }

  void store() async { // Function Set bolean value to sharedpreferences 
    var pref = await SharedPreferences.getInstance();
    pref.setBool('log', true);
  }
}
