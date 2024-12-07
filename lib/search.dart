import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'generate.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SerchState();
  }
}

class SerchState extends State<Search> {
  var time = true;
  var search = TextEditingController();
  var errSearch = null;
  var t = 1;
  var url, allData, news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: const Text(
          "Search",
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
            : ListView(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 30, right: 30, left: 30),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: search,
                      style: TextStyle(color: Colors.white),
                      cursorErrorColor: Colors.red,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          error: errSearch,
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
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.search_rounded,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                check();
                              }),
                          labelText: 'Search...',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  t == 1
                      ? Container()
                      : t == 2
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
                          : t == 3
                              ? Container(
                                  width: double.infinity,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.report_problem_outlined,
                                        size: 105,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 18.0),
                                        child: Text(
                                          "Network Problem",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 700,
                                  child: GenrateCard(news),
                                  padding: EdgeInsets.only(bottom: 78),
                                ),
                ],
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      time = false;
      setState(() {});
    });
  }

  void check() {
    if (search.text == '') {
      errSearch = const Text(
        "Please enter the search filed.",
        style: TextStyle(
            fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
      );
      setState(() {});
    } else {
      errSearch = null;
      url =
          'https://newsdata.io/api/1/latest?apikey=pub_6154786fd050e8c7d7c61bc91d3d1619550f8&language=en&country=in&q=${search.text.toLowerCase()}';
      t = 2;
      setState(() {});
      getData();
    }
  }

  Future<void> getData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      allData = response.body;
      news = jsonDecode(allData)['results'];
      t = 4;
      setState(() {});
    } else {
      t = 3;
      setState(() {});
    }
  }
}
