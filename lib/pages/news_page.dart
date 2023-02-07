import 'package:flutter/material.dart';
import '../bloc/news_bloc.dart';
import '../models/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
 
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
      backgroundColor: Color(0Xff464646),
      appBar: AppBar(backgroundColor:Color(0xFF000000) ,
        title: Center(
          child: Text('HEADLINES',
           style: GoogleFonts.robotoSlab(color: Color(0xFFffffff),
            fontSize: 29.sp, fontWeight: FontWeight.bold,)  ,)
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
        margin: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 24),
        decoration: BoxDecoration(
          //color: Colors.white,
          image: DecorationImage(image:NetworkImage(model.articles![index].urlToImage.toString()),
          fit: BoxFit.fill,
            ),
          borderRadius: BorderRadius.circular(5),),
        child: Padding(
          padding:  EdgeInsets.only(top: 50.sp, bottom: 12 , left: 5),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Articles: ${model.articles![index].title}".toUpperCase(),  
              style: GoogleFonts.robotoSlab(color: Color(0xFFf2f2f2),
                       fontSize: 20.sp, fontWeight: FontWeight.w400,) ),
                       
             SizedBox(height: 24,),        

             
               Text("Articles: ${model.articles![index].author}".toUpperCase(),
               style: GoogleFonts.robotoSlab(color: Color(0xFFbababa),
                   fontSize: 12.sp, fontWeight: FontWeight.w700,)),
         
            
            ],

          ),
         
        ),
      );
    },
    
    );
}

Widget _buildLoading() => const Center (child: CircularProgressIndicator());

}