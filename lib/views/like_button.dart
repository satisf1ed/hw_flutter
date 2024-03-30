import 'package:flutter/material.dart';
import 'package:hw_flutter/providers/saved_provider.dart';
import 'package:provider/provider.dart';

import '../models/article.dart';

class LikeButton extends StatelessWidget {
  final void Function()? onTap;
  final Article article;

  const LikeButton({super.key, required this.onTap, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Provider.of<SavedArticlesProvider>(context).isExist(article)
            ? Icons.favorite
            : Icons.favorite_border,
        color: Provider.of<SavedArticlesProvider>(context).isExist(article)
            ? Colors.red
            : Colors.grey,
      ),
    );
  }
}
