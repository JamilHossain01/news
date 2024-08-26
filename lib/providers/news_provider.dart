import 'package:flutter/cupertino.dart';
import 'package:news71_app/services/news_api.dart';

import '../models/newsModel.dart';

class NewsProvider with ChangeNotifier{
  List<NewsModel> newsList = [];
  List<NewsModel> get getNewsList{
    return newsList;
  }
  Future<List<NewsModel>> fetchAllNews()async{
    newsList= await  NewsApiServices().getAllNews();
    return newsList;
  }
}