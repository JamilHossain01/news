import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/utils.dart';

class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({Key? key}) : super(key: key);

  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  late final WebViewController _webViewController;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          setState(() {
            _progress = progress / 100;
          });
        },
      ))
      ..loadRequest(Uri.parse("https://github.com/JamilHossain01/news"));
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "URL",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrowLeft2)),
          actions: [
            IconButton(
              onPressed: () {
                _showModalSheetFct();
              },
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(mainAxisSize: MainAxisSize.min,
          children: [
            _progress < 1.0
                ? LinearProgressIndicator(
                    value: _progress,
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: WebViewWidget(controller: _webViewController),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModalSheetFct() async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )
      ),
        context: context,
        builder: (context) {
          return Container(

            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40)
              ),

              
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  height: 4,
                  width: 25,
                  color: Colors.black,
                )
              ],
            ),
          );
        });
  }
}
