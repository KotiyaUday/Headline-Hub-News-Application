import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return weatherState();
  }
}

class weatherState extends State<weather> {
  var time = true;
  var search = TextEditingController();
  var errSearch = null;
  var t = 1;
  var url, allData, report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: const Text(
          "Weather Report",
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
                    // Text Filead For the serach
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
                          labelText: 'Search City Weather...',
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
                                      Icon(Icons.report_problem_outlined,
                                          size: 105, color: Colors.red),
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
                              : t == 5
                                  ? Container(
                                      width: double.infinity,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error_outline,
                                              size: 105, color: Colors.red),
                                          Padding(
                                            padding: EdgeInsets.only(top: 18.0),
                                            child: Text(
                                              "Data not found.",
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
                                      height: 205, child: Generate(report)),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 600,
                      // color: Colors.amber,
                      child: byDefault(),
                    ),
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
          'https://api.weatherapi.com/v1/current.json?key=e8de875ad1264214a7754459240508&q=${search.text}&aqi=no';
      t = 2;
      setState(() {});
      getData();
    }
  }

  Future<void> getData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      allData = response.body;
      report = jsonDecode(allData);
      t = 4;
      setState(() {});
    } else if (response.statusCode == 400) {
      t = 5;
      setState(() {});
    } else {
      t = 3;
      setState(() {});
    }
  }
}

// ignore: must_be_immutable
class Generate extends StatefulWidget {
  var oriData;
  Generate(data) {
    oriData = data;
  }

  @override
  State<StatefulWidget> createState() {
    return GenerateState(oriData);
  }
}

class GenerateState extends State<Generate> {
  var oriData;
  GenerateState(data) {
    oriData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(8.0),
        color: Colors.blue.shade100,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.c,
          children: [
            ListTile(
              title: Text(
                "${oriData['location']['name']}",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${oriData['location']['region']}, ${oriData['location']['country']}",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https:${oriData['current']['condition']['icon']}',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${oriData['current']['temp_c']} °C",
                  style: const TextStyle(
                      fontSize: 38,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                        TextSpan(text: "Wind Speed : "),
                        TextSpan(
                          text: "${oriData['current']['wind_kph']} kph",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class byDefault extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return byDefaultState();
  }
}

class byDefaultState extends State<byDefault> {
  var time = true;
  var cities = [
    'Ahmedabad',
    'Bengaluru',
    'Kolkata',
    'Mumbai',
    'New Delhi',
    'New York',
    'London',
    'Moscow',
    'Paris',
    'Singapore'
  ];
  late var data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    for (int i = 0; i < cities.length; i++) {
      var url =
          'https://api.weatherapi.com/v1/current.json?key=e8de875ad1264214a7754459240508&q=${cities[i]}&aqi=no';
      var response = await http.get(Uri.parse(url));
      var allData = response.body;
      data.add(jsonDecode(allData));
    }
    // print("--------------------- ${data} ---------------------");
    time = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return time
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
        : ListWheelScrollView(
            // diameterRatio: 0.2,
            // offAxisFraction: -0.4,
            // offAxisFraction: -0.4,
            itemExtent: 200,
            children: List.generate(data.length, (index) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.all(2.0),
                color: Colors.blue.shade100,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.c,
                  children: [
                    ListTile(
                      title: Text(
                        "${data[index]['location']['name']}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${data[index]['location']['region']}, ${data[index]['location']['country']}",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https:${data[index]['current']['condition']['icon']}',
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${data[index]['current']['temp_c']} °C",
                          style: const TextStyle(
                              fontSize: 38,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  children: [
                                TextSpan(text: "Wind Speed : "),
                                TextSpan(
                                  text:
                                      "${data[index]['current']['wind_kph']} kph",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ])),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
