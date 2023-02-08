import 'package:dio/dio.dart';
import '../models/news_model.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio _dio = Dio();
  //final String _url = 'https://newsapi.org/v2/everything?q=tesla&from=2023-01-06&sortBy=publishedAt&apiKey=4b95d195f5d646ecafa3a55217b7e01f';
final String _url ='https://newsapi.org/v2/everything?q=tesla&from=2023-01-08&sortBy=publishedAt&apiKey=4b95d195f5d646ecafa3a55217b7e01f';
Future<NewsModel> fetchNewsList() async {
  try {
    Response response = await _dio.get(_url);
    return NewsModel.fromJson(response.data);
  }
  catch(error,stacktrace )
  {
 if(kDebugMode){
  print("Exception occured: $error stackTrack: $stacktrace");
 }
 return NewsModel.withError("Data not Found / Connection Issue");
  } 

  }
}
