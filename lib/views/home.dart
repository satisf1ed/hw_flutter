import 'package:flutter/material.dart';
import 'package:hw_flutter/views/article_view.dart';
import 'package:hw_flutter/views/errors.dart';
import 'package:hw_flutter/views/tabbar.dart';
import '../data/news.dart';
import '../models/article.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Article> articles;
  bool needToLoad = true;

  @override
  void initState() {
    super.initState();
    getNews();

    // print(categories[0].imageUrl);
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
      length: 2,
      child: Scaffold(
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
        body: TabBarView(children: [
          needToLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        /// Blogs
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BasicTile(
                                imageUrl: articles[index].imageUrl,
                                title: articles[index].title,
                                description: articles[index].description,
                                url: articles[index].url,
                                content: articles[index].content,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          const ToggleButtonsSample(title: 'title'),
        ]),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
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

/// Tile of one blog
class BasicTile extends StatelessWidget {
  const BasicTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.url,
      required this.content});

  final String title, description, url, imageUrl, content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                    imageUrl: imageUrl,
                    title: title,
                    url: url,
                    description: description,
                    content: content)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl, errorBuilder:
                    (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                  return const ErrorImage();
                })),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                  // color: Colors.black54,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
