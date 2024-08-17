import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news71_app/services/utils.dart';

import '../widgets/article.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {


  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text(
            'Bookmark',
            style: GoogleFonts.lobster(
                textStyle:
                TextStyle(color: color, letterSpacing: 0.6, fontSize: 20)),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (ctx, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: ArticleWidgets(),
            );
          }),

    );
  }
}
