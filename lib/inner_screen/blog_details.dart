import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const routeName = "/NewsDetailsScreen";

  const NewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('By Author'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title' * 10,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('20/7/2024'),
                    Text('Reading Time text'),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: 25),
                        child: FancyShimmerImage(
                          width: double.infinity,

                            imageUrl:
                            'https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1'),
                      ),

                    ),Positioned(bottom:0,
                      right: 10,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [

                            GestureDetector(
                                onTap: (){},
                                child:
                                const Card(shape: CircleBorder(),elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(IconlyLight.send),
                                  ),
                                )),
                            GestureDetector(
                              onTap: (){
                                print('ok');
                              },
                              child:
                              const Card(shape: CircleBorder(),elevation: 10,
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
                TextContent(
                    label: 'Description',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                TextContent(
                    label: 'Description' * 10,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                TextContent(
                    label: 'Content',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                TextContent(
                    label: 'Content' * 10,
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
