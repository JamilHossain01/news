import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news71_app/models/newsModel.dart';
import 'package:news71_app/providers/news_provider.dart';
import 'package:news71_app/services/utils.dart';
import 'package:news71_app/widgets/empty_screen_widget.dart';
import 'package:news71_app/widgets/vertical_space.dart';
import 'package:provider/provider.dart';

import '../consts/vars.dart';
import '../widgets/articles_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextController;
  late final FocusNode _focusNode;
  List<NewsModel> searchList = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;
    var size = Utils(context).getScreenSize;
    final newsProvider = Provider.of<NewsProvider>(context);

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
                      child: const Icon(IconlyLight.arrowLeft2),
                    ),
                    Flexible(
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _searchTextController,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        onEditingComplete: () async {
                          searchList = await newsProvider.searchNewsProvider(query: _searchTextController.text);
                          _focusNode.unfocus();
                          setState(() {
                            isSearching = true;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          contentPadding: const EdgeInsets.only(bottom: 8.0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffix: GestureDetector(
                            onTap: () {
                              _searchTextController.clear();
                              setState(() {
                                isSearching = false;
                                searchList.clear();
                              });
                            },
                            child: const Icon(
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
              VerticalSpacing(10),
              if (!isSearching && searchList.isEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MasonryGridView.count(
                      itemCount: searchKeywords.length,
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            _searchTextController.text = searchKeywords[index];
                            searchList = await newsProvider.searchNewsProvider(query: searchKeywords[index]);
                            _focusNode.unfocus();
                            setState(() {
                              isSearching = true;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: color),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(searchKeywords[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              if (isSearching && searchList.isEmpty)
                const Flexible(
                  child: EmptyWidget(
                    text: 'Oh! No result',
                    imagePath: 'assets/images/search.png',
                  ),
                ),
              if (searchList != null && searchList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchList.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: searchList[index],
                        child: const ArticlesWidget(),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

