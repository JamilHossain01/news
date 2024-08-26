import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news71_app/consts/vars.dart';
import 'package:news71_app/inner_screen/news_detaiels_webview.dart';
import 'package:news71_app/models/newsModel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../inner_screen/blog_details.dart';

class ArticleWidgets extends StatelessWidget {
  const ArticleWidgets({Key? key, });
  //final String imageUrl,title,dateShow,url,readingTimeText;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final newsModelProvider=Provider.of<NewsModel>(context);
    return Material(
      color: Theme.of(context).cardColor,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NewsDetailsScreen.routeName);
        },
        child: Stack(
          children: [
            Positioned(
              left: 0, // Added left position
              top: 0,  // Added top position
              height: 60,
              width: 60,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              height: 60,
              width: 60,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: FancyShimmerImage(
                        height: size.height*0.12,
                        width: size.height*0.12,
                        boxFit: BoxFit.fill,
                        imageUrl:newsModelProvider.urlToImage,

                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                        children: [
                          Text(newsModelProvider.title,
                            textAlign: TextAlign.justify,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: smallTextStyle,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒 ${newsModelProvider.readingTimeText}',
                              style: smallTextStyle,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: NewsDetailsWebView(url:newsModelProvider.url,),
                                      inheritTheme: true,
                                      ctx: context,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.link),
                              ),
                              Text(
                                newsModelProvider.dateToShow,
                                style: smallTextStyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
