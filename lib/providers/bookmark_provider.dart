import 'dart:convert';
import 'dart:math';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:news71_app/consts/api_conts.dart';
import 'package:http/http.dart' as http;
import 'package:news71_app/models/newsModel.dart';

import '../models/bookMarks_Model.dart';
import '../services/news_api.dart';

class BookMarkProvider with ChangeNotifier {
  List<BookmarksModel> bookMarkList = [];

  List<BookmarksModel> get getbookMarkList {
    return bookMarkList;
  }

  Future<List<BookmarksModel>> fetcBookmarks() async {
    bookMarkList = await NewsAPiServices.getBookMarks() ?? [];
    return bookMarkList;
  }

  Future<void> addToBookmark({required NewsModel newsModel}) async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "BookMArks.json");
      var response = await http.post(uri,
          body: jsonEncode(
            newsModel.toJson(),
          ));
      // log('Response body: ${response.body}'log('response status: ${response.statusCode}),
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteToBookmark() async {
    try {
      var uri =
          Uri.https(BASEURL_FIREBASE, "Bookmarks.json");
      var response = await http.delete(
        uri,
      );
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}' as num);
    } catch (error) {
      rethrow;
    }
  }
}
