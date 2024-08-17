import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

enum NewsType{
  topTrending,
  allNews,

}

enum SortByEnum{
  relevancy,
  published,
  popularity,
}
TextStyle smallTextStyle = GoogleFonts.montserrat(fontSize: 15);

List<String> searchKeyword =[
  'Football',
  'Hockey',
  'Netflix',
  'Cricket',
  'Top news',
  'daily-star',
  'flutter',
  'bloc',
  'get x'
];