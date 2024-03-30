import 'package:flutter_test/flutter_test.dart';
import 'package:hw_flutter/data/news.dart';
import 'package:hw_flutter/models/article.dart';
import 'package:hw_flutter/providers/saved_provider.dart';

void main() {
  /// TEST 1
  test('Testing SavedProvider', () async {
    // ARRANGE
    final articles = [
      Article(
          'author1', 'title1', 'description1', 'url1', 'imageUrl1', 'content1'),
      Article(
          'author2', 'title2', 'description2', 'url2', 'imageUrl2', 'content2'),
    ];
    final provider = SavedArticlesProvider();
    expect(provider.getData.isEmpty, true);

    // ACT
    provider.toggleSaved(articles[1]);

    // ASSERT
    expect(provider.getData.length, 1);
    expect(provider.getData[0].content, 'content2');
    expect(provider.isExist(articles[1]), true);

    // ACT
    provider.toggleSaved(articles[1]);

    // ASSERT
    expect(provider.getData.isEmpty, true);
    expect(provider.isExist(articles[1]), false);
  });

  /// TEST 2
  test('Getting data from newsapi', () async {
    // ARRANGE
    final newsService = News();

    // ACT
    await newsService.getNews();

    // ASSERT
    expect(newsService.news.isNotEmpty, true);
    for (var element in newsService.news) {
      expect(
          element.url != '' &&
              element.description != '' &&
              element.content != '',
          true);
    }
  });
}
