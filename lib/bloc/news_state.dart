// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  List<ArticleModel> newsData;
  NewsLoaded({
    required this.newsData,
  });
}
