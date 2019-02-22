/* 
public class Source
{
    public string id { get; set; }
    public string name { get; set; }
    public string description { get; set; }
    public string url { get; set; }
    public string category { get; set; }
    public string language { get; set; }
    public string country { get; set; }
}

public class RootObject
{
    public string status { get; set; }
    public List<Source> sources { get; set; }
}

*/

/*
public class Article
{
    public Source source { get; set; }
    public string author { get; set; }
    public string title { get; set; }
    public string description { get; set; }
    public string url { get; set; }
    public string urlToImage { get; set; }
    public DateTime publishedAt { get; set; }
    public string content { get; set; }
}
*/

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

class Search{  
      String status;
      String totalResults;
      String articles;
    
      Search({ 
        this.status,this.totalResults,this.articles,
      });
      
      static Search fromJson(Map<String,dynamic> json){
        return Search( 
            status: json['status'],
            totalResults: json['totalResults'],
            articles: json['articles'],
        );
      }
      
      Map<String, dynamic> toJson() => { 
            'status': status,
            'totalResults': totalResults,
            'articles': articles,
      };
    }
