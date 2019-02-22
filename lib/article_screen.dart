import 'dart:async';
import 'dart:convert';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reggo_news/Model/model.dart';
import 'package:reggo_news/main.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String URL;
String bar_title;

String API_KEY = '427cae42073e49a5829be896c0e82ce3';
Future<List<Article>> fetchArticleBySource(String source) async {
  final response = await http.get(
      'https://newsapi.org/v2/top-headlines?sources=${source}&apiKey=${API_KEY}');

  if (response.statusCode == 200) {
    List articles = json.decode(response.body)['articles'];
    return articles.map((article) => new Article.fromJson(article)).toList();
  } else {
    throw Exception('Failed to load article list');
  }
}

class ArticleScreen extends StatefulWidget {
  final Source source;

  ArticleScreen({Key key, @required this.source}) : super(key: key);

  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final webview = FlutterWebviewPlugin();

  // static final MobileAdTargetingInfo targetInfo = MobileAdTargetingInfo(
  //     testDevices: <String>[],
  //     keywords: <String>['technology', 'news', 'finance'],
  //     birthday: DateTime.now());

  // BannerAd _bannerAd;
  // InterstitialAd _interstitialAd;

  // InterstitialAd createInterstitialAd() {
  //   return InterstitialAd(
  //       adUnitId: 'ca-app-pub-1231182984101148/2612613872',
  //       targetingInfo: targetInfo);
  // }

  var list_articles;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshListArticle();
    webview.close();
    // FirebaseAdMob.instance
    //     .initialize(appId: 'ca-app-pub-1231182984101148~2832105723');
    // _interstitialAd = createInterstitialAd()
    //   ..load()
    //   ..show();
  }

  @override
  void dispose() {
    webview.dispose();
    super.dispose();
    // _interstitialAd.dispose();
  }

  Future<Null> refreshListArticle() async {
    refreshKey.currentState?.show(atTop: false);

    setState(() {
      list_articles = fetchArticleBySource(widget.source.id);
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/': (_) => TabScreen(),
        '/webview': (_) => WebviewScaffold(
              url: URL,
              appBar: AppBar(
                title: Text('${bar_title}'),
              ),
              withJavascript: true,
              withLocalStorage: true,
              withZoom: true,
              hidden: true,
            ),
      },
      title: 'Reggo News',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.source.name,
            style: TextStyle(color: Colors.red),
          ),
          elevation: 0.0,
        ),
        body: Center(
          child: RefreshIndicator(
            key: refreshKey,
            child: FutureBuilder<List<Article>>(
                future: list_articles,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return InkWell(
                      // When the user taps the button, show a snackbar
                      onTap: () {
                        // Scaffold.of(context).showSnackBar(SnackBar(
                        //   content: Text('Tap'),
                        // ));
                        refreshListArticle();
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
                                  color: Color(0xFF858585),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    List<Article> articles = snapshot.data;

                    return ListView(
                      children: articles
                          .map((article) => GestureDetector(
                                onTap: () {
                                  // createInterstitialAd()
                                  //   ..load()
                                  //   ..show();
                                  bar_title = article.title;

                                  CircularProgressIndicator();
                                  URL = article.url;
                                  Navigator.of(context).pushNamed('/webview');
                                },
                                child: Card(
                                  elevation: 1.0,
                                  color: Colors.white,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 4.0),
                                        width: 100.0,
                                        height: 100.0,
                                        child: article.urlToImage != null
                                            ? Image.network(article.urlToImage)
                                            : SvgPicture.asset(
                                                'lib/images/tablet.svg',
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
                                                  margin: const EdgeInsets.only(
                                                      left: 8.0,
                                                      top: 20.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    '${article.title}',
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              '${article.description}',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 10,
                                                bottom: 10.0),
                                            child: Text(
                                              'Date: ${article.publishedAt}',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            onRefresh: refreshListArticle,
          ),
        ),
      ),
    );
  }

  // _launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url, forceSafariVC: true, forceWebView: true);
  //   } else {
  //     throw ('couldn\'t open ${url}');
  //   }
  // }

}
