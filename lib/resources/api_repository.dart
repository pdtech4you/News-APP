import '../models/news_model.dart';
import 'api_provider.dart';

class ApiRepository{

final _provider = ApiProvider();
Future <NewsModel> fetchNewsList(){
  return _provider.fetchNewsList();
}
}
class NetworkError extends Error {}