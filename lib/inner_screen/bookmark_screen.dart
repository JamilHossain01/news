import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news71_app/consts/vars.dart';
import 'package:news71_app/models/bookMarks_Model.dart';
import 'package:news71_app/providers/bookmark_provider.dart';
import 'package:news71_app/widgets/articles_widget.dart';
import 'package:news71_app/widgets/empty_screen_widget.dart';
import 'package:news71_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import '../services/utils.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(
            textStyle: TextStyle(color: color, fontSize: 20, letterSpacing: 0.6),
          ),
        ),
      ),
      body: FutureBuilder<List<BookmarksModel>>(
        future: Provider.of<BookMarkProvider>(context, listen: false).fetcBookmarks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget(newsType: NewsType.allNews);
          } else if (snapshot.hasError) {
            return EmptyWidget(
              text: 'Error: ${snapshot.error}',
              imagePath: 'assets/images/no_news.png',
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyWidget(
              text: 'No news available',
              imagePath: 'assets/images/no_news.png',
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: ArticlesWidget(
                  isInBookmark: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
