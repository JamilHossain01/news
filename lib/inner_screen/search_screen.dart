import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news71_app/consts/vars.dart';
import 'package:news71_app/services/utils.dart';
import 'package:news71_app/widgets/empty_screen_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    if (mounted) {
      _searchTextController.dispose();
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;
    var size = Utils(context).getScreenSize;
    return SafeArea(
      child: Scaffold(
          body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _focusNode.unfocus();
                        Navigator.pop(context);
                      },
                      child: Icon(IconlyLight.arrowLeft2)),
                  Flexible(
                    child: TextField(
                      onTap: () {},
                      focusNode: FocusNode(),
                      controller: _searchTextController,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: () {},
                      decoration: InputDecoration(
                        hintText: 'Search',
                        contentPadding: EdgeInsets.only(bottom: 8 / 4),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffix: GestureDetector(
                          onTap: () {
                            _searchTextController.clear();
                            setState(() {});
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                itemCount: searchKeyword.length,
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: (){
                    print('ok1');
                  },
                    child: Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(color:color,),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(searchKeyword[index])),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
            EmptyWidget(text: 'Oh! No result', imagePath:'assets/images/search.png')
            
          ],
        ),
      )),
    );
  }
}
