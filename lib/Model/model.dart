import 'dart:core';

class NewsApi {
  final String status;
  final List<Source> sources;

  NewsApi({this.sources, this.status});

  factory NewsApi.fromJson(Map<String, dynamic> json) {
    return NewsApi(
        status: json['status'],
        sources: (json['sources'] as List)
            .map((source) => Source.fromJson(source))
            .toList());
  }
}

//Article section
class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJsonForArticle(json['source']),
        author: json['author'],
        description: json['description'],
        url: json['url'],
        title: json['title'],
        urlToImage: json['urlToImage'],
        content: json['content'],
        publishedAt: json['publishedAt']);
  }
}

class Source {
  // final Source source ;
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  //final DateTime publishedAt ;
  final String country;

  Source(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.country,
      this.language});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        url: json['url'],
        category: json['category'],
        country: json['country'],
        language: json['language']);
  }

  factory Source.fromJsonForArticle(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}

//Nigeria
class Nigeria{  
      // String status;
      // String totalResults;
      // String articles; 
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
    
      Nigeria({this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content, 
        
      });
      
      // static Nigeria fromJson(Map<String,dynamic> json){
      //   return Nigeria( 
      //       status: json['status'],
      //       totalResults: json['totalResults'],
      //       articles: json['articles'],
      //       author: json['author'],
      //   description: json['description'],
      //   url: json['url'],
      //   title: json['title'],
      //   urlToImage: json['urlToImage'],
      //   content: json['content'],
      //   publishedAt: json['publishedAt']
      //   );
      // }
      
      factory Nigeria.fromJson(Map<String, dynamic> json) {
    return Nigeria(
        author: json['author'],
        description: json['description'],
        url: json['url'],
        title: json['title'],
        urlToImage: json['urlToImage'],
        content: json['content'],
        publishedAt: json['publishedAt']);
  }
      
      // Map<String, dynamic> toJson() => { 
      //       'status': status,
      //       'totalResults': totalResults,
      //       'articles': articles,
      // };
    }