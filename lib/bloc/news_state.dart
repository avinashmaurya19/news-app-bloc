part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsFetched extends NewsState {
  final List<dynamic> news;

  NewsFetched(this.news);
}
