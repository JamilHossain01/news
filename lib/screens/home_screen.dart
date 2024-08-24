import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news71_app/consts/vars.dart';
import 'package:news71_app/services/news_api.dart';
import 'package:news71_app/services/utils.dart';
import 'package:news71_app/widgets/drawer_widgets.dart';
import 'package:news71_app/inner_screen/search_screen.dart';
import 'package:news71_app/widgets/tabs.dart';
import 'package:news71_app/widgets/top_trending_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../methods/newsModel.dart';
import '../providers/theme_provider.dart';
import '../widgets/article.dart';
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
  List<NewsModel> newsList = [];
  // Added loading state

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNewsList(); // Fetch news on dependencies change
  }

  Future<void> getNewsList() async {
    newsList = await NewsApiServices().getAllNews();
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text(
            'News App',
            style: GoogleFonts.lobster(
                textStyle: TextStyle(color: color, letterSpacing: 0.6, fontSize: 20)),
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
      body:  Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              TabsWidgets(
                  text: 'All News',
                  color: newsType == NewsType.allNews
                      ? Theme.of(context).cardColor
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
                      ? Theme.of(context).cardColor
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
                      // sortBy = value!;
                      // getNewsList(); // Call to fetch sorted news list
                    });
                  },
                ),
              ),
            ),
          ),
          if (newsType == NewsType.allNews)
            Expanded(
              child: ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (ctx, index) {
                    return ArticleWidgets(
                        imageUrl: newsList[index].urlToImage);
                  }),
            ),
          if (newsType == NewsType.topTrending)
            SizedBox(
              height: size.height * 0.6,
              child: Swiper(
                  itemWidth: size.width * 0.9,
                  viewportFraction: 0.9,
                  duration: 500,
                  autoplay: true,
                  layout: SwiperLayout.STACK,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const TopTrendingWidgets();
                  }),
            ),
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
