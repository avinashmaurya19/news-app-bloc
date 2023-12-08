import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<dynamic> news = [];
  NewsBloc() : super(NewsInitial()) {
    on<GetNews>((event, emit) async {
      final http.Response res = await http.get(Uri.parse(event.url));

      news = jsonDecode(res.body)['articles'] as List<dynamic>;

      emit(NewsFetched(news));
    });
  }
}
