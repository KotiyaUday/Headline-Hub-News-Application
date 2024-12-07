import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'registration.dart';
import 'login.dart';

var check = false;

class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return profileState();
  }
}

class profileState extends State<profile> {
  var time = true;
  var name = '';
  var email = '';
  var password = '**********';
  var pass = '';
  var show = Icon(Icons.visibility, color: Colors.white);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      retrive();
    });
  }

  void retrive() async {
    var pref = await SharedPreferences.getInstance();
    name = pref.getString('name')!;
    email = pref.getString('mail')!;
    pass = pref.getString('pass')!;
    if (name != '') {
      time = false;
      setState(() {});
    }
  }

  void logout() async {
    var pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: userRegistration(),
        type: PageTransitionType.leftToRight,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  void change() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: changePassword(),
        type: PageTransitionType.leftToRight,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade600,
          title: const Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Heading',
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
        body: Container(
            color: Colors.blue.shade300,
            child: time
                ? Container(
                    color: Colors.blue.shade300,
                    child: const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.blue,
                        strokeWidth: 5,
                      ),
                    ),
                  )
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(150)),
                          child: Center(
                            child: Text(
                              "${name[0]}",
                              style: TextStyle(fontSize: 120),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                    const TextSpan(text: 'Name : '),
                                    TextSpan(
                                        text: '${name}',
                                        style: const TextStyle(
                                            fontSize: 22, fontWeight: null)),
                                  ]))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                    const TextSpan(text: 'Email : '),
                                    TextSpan(
                                        text: '${email}',
                                        style: const TextStyle(
                                            fontSize: 22, fontWeight: null)),
                                  ]))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                    const TextSpan(text: 'Password : '),
                                    TextSpan(
                                        text: '${password}',
                                        style: const TextStyle(
                                            fontSize: 22, fontWeight: null)),
                                  ])),
                              IconButton(
                                onPressed: () {
                                  if (password == pass) {
                                    password = '*********';
                                    show = Icon(Icons.visibility,
                                        color: Colors.white);
                                  } else {
                                    password = pass;
                                    show = Icon(Icons.visibility_off,
                                        color: Colors.white);
                                  }
                                  setState(() {});
                                },
                                icon: show,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    logout();
                                  },
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    change();
                                  },
                                  child: const Text(
                                    "Change Password",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )));
  }
}

class changePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return changePasswordState();
  }
}

class changePasswordState extends State<changePassword> {
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
              child: const Center(
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
                          "Change Password",
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
  var CuPassword = TextEditingController();
  var uPassword = TextEditingController();

  var errPasswordConform = null;
  var errPassword = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
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
          padding: EdgeInsets.only(top: 30, right: 30, left: 30),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            controller: CuPassword,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            obscureText: show,
            decoration: InputDecoration(
                error: errPasswordConform,
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
                labelText: 'Conform Password',
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
              'Change',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )
      ],
    );
  }

  void check() {
    if (uPassword.text != '' && CuPassword.text != '') {
      change();
    } else {
      errPassword = errPasswordConform = null;
      setState(() {});
      if (uPassword.text == '' && '' == CuPassword.text) {
        errPassword = errPasswordConform = const Text(
          "Must be enter password and conform password.",
          style: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white),
        );
        setState(() {});
      } else if (uPassword.text == '') {
        errPassword = const Text(
          "Must be enter password.",
          style: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white),
        );
        setState(() {});
      } else if (CuPassword.text == '') {
        errPasswordConform = const Text(
          "Must be enter Conform Password.",
          style: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white),
        );
        setState(() {});
      }
    }
  }
  void change() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('pass', '${CuPassword.text}');
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: loginUser(),
        type: PageTransitionType.leftToRight,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
