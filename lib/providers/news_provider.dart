import 'package:flutter/cupertino.dart';

import '../models/newsModel.dart';
import '../services/news_api.dart';


class NewsProvider with ChangeNotifier {
  List<NewsModel> newList = [];

  List<NewsModel> get getNewsList {
    return newList;
  }

  Future<List<NewsModel>> fetchAllNews(
      {required int pageIndex, required String sortBy}) async {
    newList = await NewsAPiServices.getAllNews(page: pageIndex, sortBy: sortBy);
    return newList;
  }
}
