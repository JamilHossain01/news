import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news71_app/consts/vars.dart';
import 'package:news71_app/providers/news_provider.dart';
import 'package:news71_app/services/news_api.dart';
import 'package:news71_app/services/utils.dart';
import 'package:news71_app/widgets/drawer_widgets.dart';
import 'package:news71_app/inner_screen/search_screen.dart';
import 'package:news71_app/widgets/empty_screen_widget.dart';
import 'package:news71_app/widgets/tabs.dart';
import 'package:news71_app/widgets/top_trending_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/newsModel.dart';
import '../providers/theme_provider.dart';
import '../widgets/articles_widget.dart';
import '../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  var currentPageIndex = 0;
  String sortBy = SortByEnum.popularity.name;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'News App',
            style: GoogleFonts.lobster(
                textStyle:
                TextStyle(color: color, letterSpacing: 0.6, fontSize: 20)),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const SearchScreen(),
                    inheritTheme: true,
                    ctx: context),
              );
            },
            icon: Icon(IconlyLight.search),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              TabsWidgets(
                  text: 'All News',
                  color: newsType == NewsType.allNews
                      ? Theme.of(context).primaryColorDark
                      : Colors.transparent,
                  function: () {
                    if (newsType == NewsType.allNews) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.allNews;
                    });
                  },
                  fontSize: newsType == NewsType.allNews ? 22 : 12),
              TabsWidgets(
                  text: 'Top trending',
                  color: newsType == NewsType.topTrending
                      ? Theme.of(context).primaryColorDark
                      : Colors.transparent,
                  function: () {
                    if (newsType == NewsType.topTrending) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.topTrending;
                    });
                  },
                  fontSize: newsType == NewsType.topTrending ? 22 : 12),
            ],
          ),
          newsType == NewsType.topTrending
              ? Container()
              : SizedBox(
            height: kBottomNavigationBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                paginationButtons(
                    text: "Prev",
                    function: () {
                      if (currentPageIndex == 0) {
                        return;
                      }
                      setState(() {
                        currentPageIndex -= 1;
                      });
                    }),
                Flexible(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: 8,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Material(
                            color: currentPageIndex == index
                                ? Colors.blue
                                : Theme.of(context).cardColor,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentPageIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                paginationButtons(
                  text: "Next",
                  function: () {
                    if (currentPageIndex == 7) {
                      return;
                    }
                    setState(() {
                      currentPageIndex += 1;
                    });
                  },
                ),
              ],
            ),
          ),
          newsType == NewsType.topTrending
              ? Container()
              : Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  value: sortBy,
                  items: dropDownItems,
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                  },
                ),
              ),
            ),
          ),
          FutureBuilder<List<NewsModel>>(
              future: newsProvider.fetchAllNews(pageIndex: currentPageIndex + 1, sortBy: sortBy),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget(
                    newsType: newsType,
                  );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: EmptyWidget(
                      text: 'Error: ${snapshot.error}',
                      imagePath: 'assets/images/no_news.png',
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Expanded(
                    child: EmptyWidget(
                      text: 'No news available',
                      imagePath: 'assets/images/no_news.png',
                    ),
                  );
                }
                return newsType == NewsType.allNews
                    ? Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                          value: snapshot.data![index],
                          child: const ArticlesWidget(
                            // imageUrl: snapshot.data![index].urlToImage,
                            // title: snapshot.data![index].title,
                            // dateShow:snapshot.data![index].dateToShow,
                            // url:snapshot.data![index].url,
                            // readingTimeText: snapshot.data![index].readingTimeText,
                          ),
                        );
                      }),
                )
                    : SizedBox(
                  height: size.height * 0.6,
                  child: Swiper(
                    itemWidth: size.width * 0.9,
                    viewportFraction: 0.9,
                    duration: 500,
                    autoplay: true,
                    layout: SwiperLayout.STACK,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return TopTrendingWidgets(
                        url: snapshot.data![index].url,
                        imageUrl: snapshot.data![index].urlToImage,
                      );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.published.name,
        child: Text(SortByEnum.published.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
    ];
    return menuItem;
  }

  Widget paginationButtons({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () => function(),
      child: Text(text),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.all(5),
      ),
    );
  }
}

class TabsWidgets extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback function;
  final double fontSize;

  const TabsWidgets({
    Key? key,
    required this.text,
    required this.color,
    required this.function,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
