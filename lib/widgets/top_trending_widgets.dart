import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news71_app/consts/vars.dart';
import 'package:news71_app/services/utils.dart';

class TopTrendingWidgets extends StatefulWidget {
  const TopTrendingWidgets({super.key});

  @override
  State<TopTrendingWidgets> createState() => _TopTrendingWidgetsState();
}

class _TopTrendingWidgetsState extends State<TopTrendingWidgets> {
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          height: size.height * 0.5,
          width: double.infinity,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FancyShimmerImage(
                    height: size.height * 0.3,
                    width: size.height * 0.5,
                    imageUrl:
                        'https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1'),
              ),
              Text('Title',style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.link),
                  ),
                  const Text('20-07-2024'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
