import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reggo_news/Model/model.dart';
import 'package:reggo_news/article_screen.dart';

String API_KEY = '427cae42073e49a5829be896c0e82ce3';
String category = 'business';
Future<List<Source>> fetchNewsSource() async {
  final response = await http.get(
      'https://newsapi.org/v2/sources?category=${category}&language=en&apiKey=${API_KEY}');

  if (response.statusCode == 200) {
    List sources = json.decode(response.body)['sources'];
    return sources.map((source) => new Source.fromJson(source)).toList();
  } else {
    throw Exception('Failed to load source list');
  }
}

// void main() => runApp(new SourceScreen());

class BusinessScreen extends StatefulWidget {
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  var list_sources;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshListSource();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Business",
            style: TextStyle(color: Colors.red),
          ),
          elevation: 0.0,
        ),
        body: Center(
          child: RefreshIndicator(
            key: refreshKey,
            child: FutureBuilder<List<Source>>(
              future: list_sources,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return InkWell(
                    // When the user taps the button, show a snackbar
                    onTap: () {
                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //   content: Text('Tap'),
                      // ));
                      refreshListSource();
                    },
                    child: Container(
                      // padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: SvgPicture.asset(
                              'lib/images/file.svg',
                              height: 100,
                              width: 100,
                              color: const Color(0xFF858585),
                            ),
                          ),
                          Text(
                            'Couldn\'t fetch news, click to try again.',
                            style: TextStyle(
                                color: const Color(0xFF858585),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    List<Source> sources = snapshot.data;
                    return new ListView(
                        children: sources
                            .map((source) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ArticleScreen(source: source)));
                                  },
                                  child: Card(
                                    elevation: 1.0,
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 14.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 10),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 4.0),
                                          width: 80.0,
                                          height: 90.0,
                                          child: SvgPicture.asset(
                                            'lib/images/bar-chart.svg',
                                            height: 12,
                                            width: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20.0,
                                                              bottom: 10.0),
                                                      child: Text(
                                                        '${source.name}',
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Text(
                                                  '${source.description}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${source.category}',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList());
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            onRefresh: refreshListSource,
          ),
        ),
      ),
    );
  }

  Future<Null> refreshListSource() async {
    refreshKey.currentState?.show(atTop: false);

    setState(() {
      list_sources = fetchNewsSource();
    });

    return null;
  }
}

//#858585

// title: 'Reggo News',
// theme: ThemeData(primarySwatch: Colors.red),
// home: Scaffold(
//   appBar: AppBar(
//     backgroundColor: Colors.white,
//     title: Text(
//       "Reggo News",
//       style: TextStyle(color: Colors.red),
//     ),
//     elevation: 0.0,
//   ),
// bottomNavigationBar: BottomNavigationBar(
//   currentIndex: 0, // this will be set when a new tab is tapped
//   items: [
//     BottomNavigationBarItem(
//       icon: new Icon(Icons.home),
//       title: new Text('Home'),
//     ),
//     BottomNavigationBarItem(
//       icon: new Icon(Icons.monetization_on),
//       title: new Text('Business'),
//     ),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.golf_course), title: Text('Sports')),
//     BottomNavigationBarItem(
//       icon: new Icon(Icons.timeline),
//       title: new Text('Business'),
//     ),
//     BottomNavigationBarItem(
//       icon: new Icon(Icons.movie_filter),
//       title: new Text('Entertainment'),
//     ),
//   ],
// ),//Text('Couldn\'t fetch news, click to try again.'),
