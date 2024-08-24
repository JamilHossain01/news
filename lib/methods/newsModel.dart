import 'package:reading_time/reading_time.dart';

class NewsModel {
  String newsID;
  String sourceName;
  String authorName;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  String readingTimeText;

  NewsModel({
    required this.newsID,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.readingTimeText,
  });

  // Factory constructor to create a NewsModel from JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final title = json["title"] ?? "";
    final description = json["description"] ?? "";
    final content = json["content"] ?? "";

    return NewsModel(
      newsID: json['source']["id"] ?? "",
      sourceName: json["source"]["name"] ?? "",
      authorName: json["author"] ?? "",
      title: title,
      description: description,
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ??
          "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1",
      publishedAt: json["publishedAt"] ?? "",
      content: content,
      readingTimeText: readingTime(title + description + content).msg,
    );
  }

  // Static method to create a list of NewsModel from a snapshot
  static List<NewsModel> newsFromSnapshot(List<dynamic> newsSnapShot) {
    return newsSnapShot.map((json) {
      return NewsModel.fromJson(json);
    }).toList();
  }

  // Method to convert the NewsModel to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['newsID'] = newsID;
    data['sourceName'] = sourceName;
    data['authorName'] = authorName;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    data['readingTimeText'] = readingTimeText;
    return data;
  }
}
