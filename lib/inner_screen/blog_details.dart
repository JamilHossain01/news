import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news71_app/models/newsModel.dart';
import 'package:news71_app/providers/bookmark_provider.dart';
import 'package:news71_app/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/global_method.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const routeName = "/NewsDetailsScreen";

  const NewsDetailsScreen({super.key});

  final bool isInBookmarks = false;

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final newsBookmarkProvider = Provider.of<BookMarkProvider>(context);
    final publishedAt = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    final currentNews = newsProvider.findByDate(publishedAt: publishedAt);

    return Scaffold(
      appBar: AppBar(
        title: Text('By ${currentNews.authorName}'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentNews.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(currentNews.dateToShow),
                    Text(currentNews.readingTimeText),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Hero(tag: currentNews.publishedAt,
                          child: FancyShimmerImage(
                              width: double.infinity,
                              imageUrl: currentNews.urlToImage),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  try {
                                    await Share.share(
                                      currentNews.url,
                                      subject: 'Look what I found!',
                                    );
                                  } catch (err) {
                                    GlobalMethods.errorDialog(context: context,
                                        errorMessage: err.toString());
                                  }
                                },
                                child: const Card(
                                  shape: CircleBorder(),
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(IconlyLight.send),
                                  ),
                                )),
                            GestureDetector(
                                onTap: () async {
                                  if (isInBookmarks) {
                                    await newsBookmarkProvider
                                        .deleteToBookmark();
                                  } else {
                                    await newsBookmarkProvider.addToBookmark(
                                        newsModel: currentNews);
                                    print('ok');
                                  }

                                },
                                child: const Card(
                                  shape: CircleBorder(),
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(IconlyLight.bookmark),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const TextContent(
                    label: 'Description',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                TextContent(
                    label: currentNews.description,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                TextContent(
                    label: currentNews.content,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                TextContent(
                    label: currentNews.content,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  });

  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
