
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/news_model.dart';
import '../resources/api_repository.dart';
part  'news_event.dart';
part 'news_state.dart';
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc():super(NewsInitial()){
    final ApiRepository _apiRepository = ApiRepository();
    on <GetNewsList>((event, emit) async{
    try{
      emit(NewsLoading());
      final newsList = await _apiRepository.fetchNewsList();
      emit(NewsLoaded(newsList));
      if (newsList.error!=null){
        emit(NewsError(newsList.error));
      }
    }
    on NetworkError{
      emit(const NewsError("Faild to Fetch Data. You are Online?"));
    }
  });
  }
}