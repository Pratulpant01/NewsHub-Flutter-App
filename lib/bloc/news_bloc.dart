import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newshub/models/article_model.dart';

import '../helper/data.dart';
import '../helper/news.dart';
import '../models/category_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  News news;
  NewsBloc(this.news) : super(NewsInitial()) {
    on<GetNewsApi>((event, emit) async {
      try {
        emit(NewsLoading());
        await news.getNews();
        emit(NewsLoaded(newsData: news.newsList));
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
