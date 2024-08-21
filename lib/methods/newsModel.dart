class NewsModel {
  String newsID,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content;

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
  });

  factory NewsModel.formjson(dynamic json) {
    return NewsModel(
        newsID: json['source']["id"] ?? "",
        sourceName: json["source"]["name"] ?? "",
        authorName: json["author"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        url: json["url"],
        urlToImage: json["urlToImage"] ?? "",
        publishedAt: json["publishedAt"] ?? "",
        content: json["content"] ?? "");
  }
  static List<NewsModel>newsFormSnapshot( List newsSnapShot){
    return newsSnapShot.map((json) {
      return NewsModel.formjson(json);
    }).toList();
  }
  Map<String,dynamic> tojson(){
    final Map<String,dynamic>data={};
    data [newsID]= newsID;
    data [sourceName]= sourceName;
    data [authorName]= authorName;
    data [title]= title;
    data [description]= description;
    data [url]= url;
    data [urlToImage]= urlToImage;
    data [publishedAt]= publishedAt;
    data [content]= content;
    return data;
}
}
