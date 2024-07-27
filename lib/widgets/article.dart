import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news71_app/consts/vars.dart';

class ArticleWidgets extends StatelessWidget {
  const ArticleWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: GestureDetector(onTap: (){},
        child: Stack(
          children: [
            Positioned(
              height: 50,
              width: 50,
              child: Container(
                height: 60,
                width: 60,
                color: Colors.grey,
              ),
            ),
            Positioned(
              height: 50,
              width: 50,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                width: 60,
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: FancyShimmerImage(
                            height: 50,
                            width: 60,
                            imageUrl:
                                'https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1'),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Title' * 10,
                            textAlign: TextAlign.justify,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                              style: smallTextStyle
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒 Reading time',
                              style: smallTextStyle,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.link)),
                              Text(
                                '27/6/2024 ON 3:47',
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
