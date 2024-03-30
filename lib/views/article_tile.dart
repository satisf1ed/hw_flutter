import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/saved_provider.dart';
import 'article_view.dart';
import 'errors.dart';
import 'like_button.dart';

class BasicTile extends StatefulWidget {
  const BasicTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.url,
      required this.content,
      required this.article});

  final String title, description, url, imageUrl, content;
  final Article article;

  @override
  State<BasicTile> createState() => _BasicTileState();
}

class _BasicTileState extends State<BasicTile> {
  void toggleLike() {
    setState(() {
      Provider.of<SavedArticlesProvider>(context, listen: false)
          .toggleSaved(widget.article);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                    imageUrl: widget.imageUrl,
                    title: widget.title,
                    url: widget.url,
                    description: widget.description,
                    content: widget.content)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),

          /// Article body
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(widget.imageUrl, errorBuilder:
                      (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                    return const ErrorImage();
                  })),

              /// Title
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),

              /// Description
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              /// Article bottom bar
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(children: [
                      LikeButton(
                        onTap: toggleLike,
                        article: widget.article,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
