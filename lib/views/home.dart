import 'package:flutter/material.dart';
import 'package:hw_flutter/views/settings.dart';
import 'package:provider/provider.dart';
import '../data/news.dart';
import '../models/article.dart';
import '../providers/saved_provider.dart';
import 'feed.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Article> articles;
  List<Article> savedArticles = [];
  bool needToLoad = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      needToLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        /// App Bar
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Feed",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),

        /// Main body
        body: TabBarView(children: [
          /// Main screen
          needToLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Feed(articles: articles),

          /// Saved articles
          Feed(articles: context.watch<SavedArticlesProvider>().getData),

          /// Settings
          const ToggleButtonsSample(title: 'title'),
        ]),

        /// Bottom menu
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.turned_in),
              text: "Saved",
            ),
            Tab(
              icon: Icon(Icons.settings),
              text: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
