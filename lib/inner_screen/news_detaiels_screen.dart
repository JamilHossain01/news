import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news71_app/services/global_method.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final String url = "https://chatgpt.com/c/69c90102-3233-4813-84e8-4e52725b1085";

  @override
  void initState() {
    super.initState();

    // Initialize WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
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
            icon: const Icon(IconlyLight.arrowLeft2),
          ),
          actions: [
            IconButton(
              onPressed: _showModalSheetFct,
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _progress < 1.0
                ? LinearProgressIndicator(value: _progress)
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                height: 4,
                width: 25,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              const Text(
                'More Options',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Divider(thickness: 1, color: Colors.blueGrey),
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () async {
                  try {

                    await Share.share(
                      'Check out this website: $url',
                      subject: 'Look what I found!',
                    );
                  } catch (err) {
                    GlobalMethods.errorDialog(context: context, errorMessage:err.toString());
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.open_in_browser),
                title: const Text('Open in browser'),
                onTap: () async {
                  try {
                    if (!await launchUrl(Uri.parse(url))) {
                      throw 'Could not launch $url';
                    }
                  } catch (err) {
                    log('Error launching URL: ${err.toString()}');
                  } finally {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Refresh'),
                onTap: () async {
                  try {
                    await _webViewController.reload();
                  } catch (err) {
                    log('Error refreshing page: ${err.toString()}');
                  } finally {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
