part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable
{
const NewsEvent();
List<Object> get props=> [];
}

class GetNewsList extends NewsEvent{}