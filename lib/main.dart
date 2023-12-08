import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_news_assignment/bloc/news_bloc.dart';
import 'package:github_news_assignment/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      home: BlocProvider(
        create: (context) => NewsBloc(),
        child: HomePage(),
      ),
    );
  }
}
