import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../models/news.dart';
import 'package:http/http.dart'as http;
const mainUrl='https://newsapi.org/v2/';
const topHeadLines='top-headlines';
const apiKey='f5021dc5cd284401ae13c1ae86738e27';
News ParsNews(String responseBody){
  var l =json.decode(responseBody);
  var news =News.fromJson(l);
  return news;

}
Future<News>feachNewsByCategory(String category)async{
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