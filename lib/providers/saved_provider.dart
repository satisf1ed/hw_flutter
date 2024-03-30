import 'package:flutter/material.dart';
import '../models/article.dart';

class SavedArticlesProvider with ChangeNotifier {
  final List<Article> _articles = [];

  List<Article> get getData => _articles;

  void toggleSaved(Article article) {
    if (_articles.contains(article)) {
      _articles.remove(article);
    } else {
      _articles.add(article);
    }

    notifyListeners();
  }

  bool isExist(Article article) {
    return _articles.contains(article);
  }
}
