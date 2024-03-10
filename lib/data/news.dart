import 'dart:convert';

import '../models/article.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    Uri uri = Uri(
      scheme: "https",
      host: 'newsapi.org',
      path: '/v2/everything',
      queryParameters: {
        'q': 'tesla',
        'from': '2024-03-05',
        'sortBy': 'publishedAt',
        'apiKey': '5b6c1826880b498aae85966fbab89f7d'
      },
    );

    // print(uri);

    var response = await http.get(uri);

    // print('after getting news');

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null &&
            element["title"] != null &&
            element["url"] != null &&
            element['content'] != null) {

          Article article = Article(
            element['author'],
            element['title'],
            element['description'],
            element['url'],
            element['urlToImage'],
            element['content'],
          );

          news.add(article);
        }
      });
    }
  }
}
