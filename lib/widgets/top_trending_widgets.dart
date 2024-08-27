import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news71_app/inner_screen/blog_details.dart';
import 'package:news71_app/models/newsModel.dart';
import 'package:news71_app/providers/news_provider.dart';
import 'package:news71_app/services/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../inner_screen/news_detaiels_webview.dart';

class TopTrendingWidgets extends StatefulWidget {
  const TopTrendingWidgets({super.key, });


  @override
  State<TopTrendingWidgets> createState() => _TopTrendingWidgetsState();
}

class _TopTrendingWidgetsState extends State<TopTrendingWidgets> {
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final color = Utils(context).getColor;
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context,NewsDetailsScreen.routeName,arguments: newsModelProvider.publishedAt);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          height: size.height * 0.5,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 18,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FancyShimmerImage(
                    height: size.height * 0.3,
                    width: size.height * 0.5,
                    imageUrl:newsModelProvider.urlToImage),
              ),
               Text(
                newsModelProvider.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child:  NewsDetailsWebView(url:newsModelProvider.url,),
                            inheritTheme: true,
                            ctx: context),
                      );
                    },
                    icon: const Icon(Icons.link),
                  ),
                   Text(newsModelProvider.dateToShow),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
