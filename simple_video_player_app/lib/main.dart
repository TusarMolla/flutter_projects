import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_video_player_app/blocs/player_block.dart';
import 'package:simple_video_player_app/events/player_page_event.dart';
import 'package:simple_video_player_app/screens/player_page.dart';
import 'package:simple_video_player_app/states/home_page_state.dart';
import 'package:simple_video_player_app/blocs/home_page_bloc.dart';

void main() {
  runApp(Builder(
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomePageBloc>(create: (context) => HomePageBloc(),
            //child: MyHomePage(title: "Trending Videos"),
          ),
          BlocProvider<PlayerBloc>(create: (_) => PlayerBloc(),
            child: const PlayerPage(),
          ),
        ],
        child:const MyApp(),
      );
    }
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trending Videos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "PublicSansSerif",
        fontFamilyFallback: ['Sutonnymj'],
      ),
      home:MyHomePage(title: "Trending Videos"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(

        backgroundColor: Colors.grey.shade100,

        title: Text(widget.title),
      ),
      body: BlocBuilder<HomePageBloc,HomePageState>(
        builder: (context,state) {
          return Center(
            child: state.isDataLoaded?ListView.separated(
              padding: EdgeInsets.only(left: 14,right: 14,bottom: 14),
              controller: state.scrollController,
              itemCount: state.videos.length,
              itemBuilder: (context,index) {
                return Center(
                  child: listViewModel(state, index),
                );
              }, separatorBuilder: (BuildContext context, int index) { return  Container(
              // color: Colors.red,
              height: 14,); },
            ):const CircularProgressIndicator(),
          );
        }
      ),
    );
  }

  Widget listViewModel(HomePageState state, int index) {
    return InkWell(
      onTap: (){
        context.read<PlayerBloc>().add(PassInitialValue(state.videos[index]));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerPage()));
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.,
        child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(state.videos[index].thumbnail,
                            fit: BoxFit.cover,
                            height: 200,width: MediaQuery.of(context).size.width,),
                          Positioned(
                            right: 8,
                              bottom: 8,
                              child: Container(
                            padding:const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.black,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(state.videos[index].duration,style:const TextStyle(color: Colors.white,fontSize: 14),),
                          ))
                        ],
                      ),
                      // SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(state.videos[index].channelImage)
                                )
                              ),

                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 120,
                              padding:const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Text(state.videos[index].title,maxLines: 2,style:const TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600),),
                                  Row(
                                    children: [
                                  Text("${state.videos[index].viewers} views",style:const TextStyle(fontSize: 12,color: Colors.grey),),
                                      Container(
                                        padding:const EdgeInsets.symmetric(horizontal: 8),
                                        child:const Text(".",style: TextStyle(fontSize: 12,color: Colors.grey),),),
                                      Text(DateFormat("MMM dd, y").format(state.videos[index].dateAndTime) ,style:const TextStyle(fontSize: 12,color: Colors.grey),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                           const Icon(Icons.more_vert_rounded,size: 15,)
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
