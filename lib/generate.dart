import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

var news;
var i;

class GenrateCard extends StatefulWidget {
  GenrateCard(var data) {
    news = data;
  }

  @override
  State<StatefulWidget> createState() {
    return GenrateCardState();
  }
}

class GenrateCardState extends State<GenrateCard> {
  @override
  Widget build(BuildContext context) {
    return news.length <= 0
        ? Container(
            color: Colors.blue.shade300,
            height: 400,
            child: const Center(
              child: Text(
                "No such type of news in our app.",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ),
            ),
          )
        : Container(
            color: Colors.blue.shade300,
            child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      i = index;
                      Navigator.push(
                          context,
                          PageTransition(
                            child: GeneratePage(),
                            type: PageTransitionType.leftToRight,
                            duration: const Duration(milliseconds: 300),
                          ));
                    },
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 4),
                      color: Colors.blue.shade100,
                      child: ListTile(
                        leading: const Icon(Icons.ac_unit),
                        title: Text(
                          "${news[index]['title']}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${news[index]['pubDate'].substring(0, 10)}'),
                            Text('${news[index]['pubDate'].substring(11)}')
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GeneratePageState();
  }
}

class GeneratePageState extends State<GeneratePage> {
  var enabel = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      enabel = false;
      setState(() {});
    });
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
            appBar: AppBar(
              backgroundColor: Colors.blue.shade600,
              iconTheme: IconThemeData(color: Colors.white),
              title: const Text(
                "Headline Hub",
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
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        "${news[i]['title']}",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.ac_unit,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${news[i]['pubDate'].substring(0, 10)}',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${news[i]['pubDate'].substring(11)}',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 8, right: 8, bottom: 18.0),
                      child: news[i]['description'] == null
                          ? Text('')
                          : Text('${news[i]['description']}',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 8, right: 8, bottom: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          '${news[i]['image_url']}',
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Column(
                              children: [
                                Icon(Icons.error, color: Colors.red, size: 30),
                                Text(
                                  "Can't load image",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ); // Or you can use an image as a placeholder
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: 'By : ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' ${news[i]['source_name']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                )),
                          ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
