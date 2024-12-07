import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'generate.dart';

import 'search.dart';
import 'weather.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  var enabel = true;
  var intitialTab = 0;
  dynamic pages = [all(), Search(), weather(), profile()];

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 800), () {
      enabel = false;
      setState(() {});
    });
  }

  var selectedIndex = 0;
  void update(int i) {
    selectedIndex = i;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return enabel
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
        : Scaffold(
            body: pages[selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: selectedIndex,
                backgroundColor: Colors.blue.shade600,
                selectedItemColor: Colors.white,
                selectedFontSize: 16,
                unselectedItemColor: Colors.blue.shade200,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sunny_snowing),
                    label: "Weather",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
                onTap: (index) {
                  update(index);
                }),
          );
  }
}

class all extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return allState();
  }
}

class allState extends State<all> {
  var time = true;
  String allData = '';
  var news;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 1), () {
      // ========================================
      getData('top');
    });
  }

  var time1 = true;
  Future<void> getData(String Cato) async {
    setState(() {
      time1 = true;
    });
    // print("Function Call");
    var response = await http.get(
      Uri.parse(
        'https://newsdata.io/api/1/latest?apikey=pub_6154786fd050e8c7d7c61bc91d3d1619550f8&category=${Cato}&language=en&country=in',
      ),
    );
    // print("Dataretrive succefully");

    if (response.statusCode == 200) {
      // print("Enter in if condition");
      setState(() {
        allData = response.body;
        news = jsonDecode(allData)['results'];
        time = false;
        time1 = false;
      });
    } else {
      time = false;
      time1 = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return time
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
        : (allData == '')
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
            : DefaultTabController(
                length: 16,
                // initialIndex: intitialTab,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue.shade600,
                    title: const Text(
                      "Headline Hub",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Heading',
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      indicatorWeight: 5,
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.white54, fontSize: 18),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                      tabs: const [
                        Tab(text: 'Headlines'),
                        Tab(text: 'Business'),
                        Tab(text: 'Crime'),
                        Tab(text: 'Domestic'),
                        Tab(text: 'Education'),
                        Tab(text: 'Entertainment'),
                        Tab(text: 'Environment'),
                        Tab(text: 'Food'),
                        Tab(text: 'Health'),
                        Tab(text: 'Lifestyle'),
                        Tab(text: 'Politics'),
                        Tab(text: 'Science'),
                        Tab(text: 'Sports'),
                        Tab(text: 'Technology'),
                        Tab(text: 'Tourism'),
                        Tab(text: 'World'),
                      ],
                      onTap: (index) {
                        String catogry = '';
                        if (index <= 16) {
                          catogry = [
                            'top',
                            'business',
                            'crime',
                            'domestic',
                            'education',
                            'entertainment',
                            'environment',
                            'food',
                            'health',
                            'lifestyle',
                            'politics',
                            'science',
                            'sports',
                            'technology',
                            'tourism',
                            'world'
                          ][index];
                          getData(catogry);
                          // print(catogry);
                        }
                      },
                    ),
                  ),
                  body: time1
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
                      : Container(child: GenrateCard(news)),
                ),
              );
  }
}
