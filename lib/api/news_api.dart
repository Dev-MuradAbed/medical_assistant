import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../models/news.dart';
import 'package:http/http.dart'as http;
final mainUrl='https://newsapi.org/v2/';
final topHeadLines='top-headlines';
// final apiKey='08074b298f9f43ab9a020d6cf5c456da';
final apiKey='f5021dc5cd284401ae13c1ae86738e27';
News ParsNews(String responseBody){
  var l =json.decode(responseBody);
  var news =News.fromJson(l);
  return news;

}
Future<News>feachNewsByCategory(String category)async{
  // var url='https://newsapi.org/v2/top-headlines?country=ar&apiKey=f5021dc5cd284401ae13c1ae86738e27';
  var url='$mainUrl$topHeadLines?language =ar&category=$category&apiKey=$apiKey';
  var response=await http.get(Uri.parse(url));
  if(response.statusCode==200&&response.body!=null){
    return compute(ParsNews,response.body);
  }else if(response.statusCode==404){
    throw Exception('Not Found 404');
  }else {
    throw Exception('Cannot get News');
  }
}