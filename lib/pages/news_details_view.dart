
import 'package:flutter/material.dart';
import 'package:my_task/pages/news_page.dart';
import '../bloc/news_bloc.dart';
import '../models/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

 
class NewsDetailsView extends StatefulWidget {
  final int index;
  const NewsDetailsView({super.key, required NewsModel newsModel, required this.index});

  @override
  State<NewsDetailsView> createState() => _NewsDetailsViewState();
}

class _NewsDetailsViewState extends State<NewsDetailsView> {

final NewsBloc _newsBloc = NewsBloc();
@override
void initState(){
_newsBloc.add(GetNewsList());
super.initState();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xff464646),

      body: _buildListNews(widget.index),
    );
  }
  
Widget _buildListNews(int index){
  return Container(
   // margin: const EdgeInsets.all(8.0),
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
  return _buildCard(context , state.newsModel, index);
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
Widget _buildCard(BuildContext context , NewsModel model, int index){
  return 
       Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       // margin: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 24),
        decoration: BoxDecoration(
          //color: Colors.white,
          image: DecorationImage(image:NetworkImage(model.articles![index].urlToImage.toString()),
          fit: BoxFit.fill,
            ),
          borderRadius: BorderRadius.circular(5),),
        child: Padding(
          padding:  const EdgeInsets.only(top: 42, bottom: 12 , left: 0),
            child: 
        SingleChildScrollView(
          child: Stack(
            children: [
                Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
        
       SizedBox(
         height: 42, width: 72,
         child: ElevatedButton(
           onPressed: () {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => const NewsPage ())
              );
           },
            
           style: ButtonStyle(
             shape: MaterialStateProperty.all(const CircleBorder()),
             backgroundColor: MaterialStateProperty.all(const Color(0Xff464646)), 
               ),
                child: const Icon(Icons.arrow_back),
            ),
       ),
        

           const SizedBox(height: 100,),

              Container(
                 margin: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 4),
                
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("${model.articles![index].title}".toString(),  
                  style: GoogleFonts.robotoSlab(color: const Color(0xFFf2f2f2),
                     fontSize: 29.sp, fontWeight: FontWeight.w700,),
                     softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines:4444444,
                      ),


                const SizedBox(height: 64,),
        
        Text(" ${model.articles![index].author} ".toUpperCase(),
        
                 style: GoogleFonts.robotoSlab(color: const Color(0xFFf2f2f2),
                   fontSize: 20.sp, fontWeight: FontWeight.w400,) ,
                   softWrap: true,overflow: TextOverflow.ellipsis,maxLines:4444444,
            ),
        
         const SizedBox(height: 14,),

        Text(" ${model.articles![index].publishedAt}".toUpperCase(),
           style: GoogleFonts.robotoSlab(color: Color(0xFFf2f2f2),
             fontSize: 20.sp, fontWeight: FontWeight.w400,),
             softWrap: true,overflow: TextOverflow.ellipsis,maxLines:4444444,
        ),
        
       const SizedBox(height: 16,),

              Text(" ${model.articles![index].description}".toUpperCase(),
                 style: GoogleFonts.robotoSlab(color: Color(0xFFbababa),
                 fontSize: 14.sp, fontWeight: FontWeight.w400,),
                   softWrap: true,overflow: TextOverflow.ellipsis,maxLines:4444444,
              ),
        
        
        
                ],
                ),          
              ),
                 
                 //SizedBox(height: 24,),        
            
                 
                 
         ],
                )  
            
          ],
          ),
        )
        
        ),
      );
  
}

Widget _buildLoading() => const Center (child: CircularProgressIndicator());

}
