import 'package:flutter/material.dart';
import '../bloc/news_bloc.dart';
import '../models/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

final NewsBloc _newsBloc = NewsBloc();
@override
void initState(){
_newsBloc.add(GetNewsList());
super.initState();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: const Text('HEADLINES')
        )
        ),
      body: _buildListNews(),
    );
  }


Widget _buildListNews(){
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: BlocProvider(
      create: (_) =>_newsBloc,
      child: BlocListener< NewsBloc , NewsState>(
        listener: (context, state) {

if(state is NewsError)
{

   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content : Text(state.message!),
   ),
   );
}
   },
   child: BlocBuilder < NewsBloc , NewsState> (
    builder: (context, state) 
    {
if (state is NewsInitial){
  return _buildLoading();
} else if ( state is NewsLoading){
  return _buildLoading();     
} else if (state is NewsLoaded){
  return _buildCard(context , state.newsModel);
}else if (state is NewsError){
  return Container();
} else {
  return Container();
}


    } 
   ),
      ),
    ),

      );
}
Widget _buildCard(BuildContext context , NewsModel model){
  return ListView.builder(
    itemCount: model.articles!.length,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 196, 193, 193),width: 0.5)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget> [
   Text("Articles: ${model.articles![index].title}".toUpperCase(),),
   SizedBox(height: 10,),
Image.network(model.articles![index].urlToImage.toString()),
  Text("Articles: ${model.articles![index].description}".toUpperCase(),),
   SizedBox(height: 10,),

     Text("Articles: ${model.articles![index].author}".toUpperCase(),),
   SizedBox(height: 10,),

        ]),
      );
    },
    
    );
}


Widget _buildLoading() => const Center (child: CircularProgressIndicator());

}