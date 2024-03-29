import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_news_assignment/bloc/news_bloc.dart';
import 'package:github_news_assignment/component/drawer.dart';
import 'article_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('News'),
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
          return ListView.builder(
            itemCount: BlocProvider.of<NewsBloc>(context)
                .news
                .length, // controller: controller,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext _) => ArticalNews(
                                newsUrl: BlocProvider.of<NewsBloc>(context)
                                    .news[index]['url'] as String,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  if (BlocProvider.of<NewsBloc>(context)
                                          .news[index]['urlToImage'] ==
                                      null)
                                    Container()
                                  else
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        placeholder: (BuildContext context,
                                                String url) =>
                                            Container(),
                                        errorWidget: (BuildContext context,
                                                String url, error) =>
                                            const SizedBox(),
                                        imageUrl:
                                            BlocProvider.of<NewsBloc>(context)
                                                    .news[index]['urlToImage']
                                                as String,
                                      ),
                                    ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Card(
                                      elevation: 0,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          "${BlocProvider.of<NewsBloc>(context).news[index]['source']['name']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text(
                                "${BlocProvider.of<NewsBloc>(context).news[index]['title']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (index ==
                          BlocProvider.of<NewsBloc>(context).news.length - 1 &&
                      isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.yellow,
                      ),
                    )
                  else
                    const SizedBox(),
                ],
              );
            },
          );
        }));
  }

}
