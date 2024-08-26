import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news71_app/widgets/empty_screen_widget.dart';

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
                textStyle:
                TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
        ),
        body:const EmptyWidget(text:'ok', imagePath:"assets/images/no_news.png")
      // ListView.builder(
      //     itemCount: 20,
      //     itemBuilder: (ctx, index) {
      //       return const ArticlesWidget();
      //     }),
    );
  }
}
