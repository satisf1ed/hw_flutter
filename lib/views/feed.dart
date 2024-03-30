import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_tile.dart';

class Feed extends StatefulWidget {
  final List<Article> articles;

  const Feed({
    super.key,
    required this.articles,
  });

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return widget.articles.isEmpty
        ? const EmptyFeed()
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: ListView.builder(
                      itemCount: widget.articles.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BasicTile(
                          article: widget.articles[index],
                          imageUrl: widget.articles[index].imageUrl,
                          title: widget.articles[index].title,
                          description: widget.articles[index].description,
                          url: widget.articles[index].url,
                          content: widget.articles[index].content,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class EmptyFeed extends StatelessWidget {
  const EmptyFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Oops.. Nothing here",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
