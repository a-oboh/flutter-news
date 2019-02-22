import 'package:flutter/material.dart';
import 'homepage.dart' as source;
import 'sport.dart' as sport;
import 'business.dart' as business;
import 'entertainment.dart' as entertainment;
import 'technology.dart' as technology;
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_admob/firebase_admob.dart';

const String testDevice =
    'f3_2aeA_0kQ:APA91bFhbURleUuCqYv_TvZLmCAyQy6L-xJ4qNW_-eYfJ35jB1Nbk1sAMIzgL4v9_JpSO2aLE56G_hWH79I3r4hpwPUCCclS7UnOBzAwwtb__rVzRSyEl1O-SbNfC4neqgQCjY-XCkGk';

void main() => runApp(new TabScreen());

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  // final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 5);

    // _messaging.getToken().then((token) {
    //   print(token);
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reggo News',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: Text(
        //     "Reggo News",
        //     style: TextStyle(color: Colors.red),
        //   ),
        //   elevation: 0.0,
        // ),

        bottomNavigationBar: TabBar(
          unselectedLabelColor: Colors.red,
          labelColor: Colors.red,
          controller: controller,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.monetization_on)),
            Tab(icon: Icon(Icons.golf_course)),
            Tab(icon: Icon(Icons.movie_filter)),
            Tab(icon: Icon(Icons.timeline)),
          ],
        ),

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
        // ),

        body: TabBarView(
          controller: controller,
          children: <Widget>[
            source.SourceScreen(),
            business.BusinessScreen(),
            sport.SportScreen(),
            entertainment.EntScreen(),
            technology.TechScreen()
          ],
        ),
      ),
    );
  }
}

//#858585

//Text('Couldn\'t fetch news, click to try again.'),
