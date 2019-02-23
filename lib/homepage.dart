import 'dart:async';
import 'dart:convert';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reggo_news/Model/model.dart';
import 'package:reggo_news/article_screen.dart';
import 'package:reggo_news/nigeria.dart';
import 'package:reggo_news/search.dart';
import 'main.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geolocator/geolocator.dart';


String API_KEY = '427cae42073e49a5829be896c0e82ce3';
Future<List<Source>> fetchNewsSource() async {
  final response = await http
      .get('https://newsapi.org/v2/sources?language=en&apiKey=${API_KEY}');

  if (response.statusCode == 200) {
    List sources = json.decode(response.body)['sources'];
    return sources.map((source) => new Source.fromJson(source)).toList();
  } else {
    throw Exception('Failed to load source list');
  }
}

// void main() => runApp(new SourceScreen());

class SourceScreen extends StatefulWidget {
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
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
      routes: {'/nigeria': (_) => Nigeria()},
      title: 'Reggo news',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.red),
          actions: <Widget>[
            IconButton(
              tooltip: 'Search news',
              icon:Icon(
                Icons.search,
                color: Colors.red,
              ),
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              }
          )
            // IconButton(
            //     icon: Icon(Icons.location_on),
            //     onPressed: () {
            //       Future<Position> locateUser() async {
            //         return Geolocator()
            //             .getCurrentPosition(
            //                 desiredAccuracy: LocationAccuracy.high)
            //             .then((location) {
            //           if (location.latitude == 9.0820 &&
            //               location.longitude == 8.6753) {
            //             print(
            //                 "Location: ${location.latitude},${location.longitude}");
            //             Navigator.pushNamed(context, '/nigeria');
            //           } else {}
            //           return location;
            //         });
            //       }
            //     }),
          ],
          backgroundColor: Colors.white,
          title: Text(
            "Reggo news",
            style: TextStyle(color: Colors.red),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     color: Colors.red,
          //     icon: Icon(Icons.search),
          //     tooltip: 'search for news',
          //     onPressed: () {
          //       showSearch(context: context, delegate: DataSearch());
          //     },
          //   )
          // ],
          elevation: 0.0,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: () {
                  
                },
                child: ListTile(
                  title: Text("Local news"),
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
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
                                    Navigator.of(context).push(
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
                                            'assets/newspaper.svg',
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

class DataSearch extends SearchDelegate<String> {
  List titles = sourcequery;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = question;
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final suggestionList = query.isEmpty;
  }
}

List sourcequery;
String question;

Future<List<Article>> searchNews(String source) async {
  final response = await http.get(
      'https://newsapi.org/v2/top-headlines?q={$question}&apiKey=${API_KEY}');

  sourcequery = json.decode(response.body)['articles']['title'];
  return sourcequery.map((article) => new Article.fromJson(article)).toList();
}

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
//       title: new Text('Tech'),
//     ),
//     BottomNavigationBarItem(
//       icon: new Icon(Icons.movie_filter),
//       title: new Text('Entertainment'),
//     ),
//   ],
// ),//Text('Couldn\'t fetch news, click to try again.'),
