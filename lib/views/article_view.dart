import 'package:flutter/material.dart';
import 'package:hw_flutter/views/errors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String url;
  final String content;

  const ArticleView(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.url,
      required this.content});

  void _handleURLButtonPress(BuildContext context, String url, String title, WebViewController controller) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewWidget(controller: controller,)));
  }

  @override
  Widget build(BuildContext context) {
    late final WebViewController controller;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Feed", style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Image.network(imageUrl, errorBuilder:
                      (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                    return const ErrorImage();
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Colors.blue,
                    child: Text(
                      "More...",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onPressed: () {
                      _handleURLButtonPress(context, url, "Original Source", controller);
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
