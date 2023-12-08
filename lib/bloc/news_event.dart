part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class GetNews extends NewsEvent{
  final String url;

  GetNews(this.url);
}
