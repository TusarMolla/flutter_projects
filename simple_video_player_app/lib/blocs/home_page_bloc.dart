import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_video_player_app/events/event.dart';
import 'package:simple_video_player_app/events/home_page_event.dart';
import 'package:simple_video_player_app/states/home_page_state.dart';
import 'package:simple_video_player_app/player_list_response.dart';
import 'package:simple_video_player_app/player_repository.dart';

class HomePageBloc extends Bloc<Event,HomePageState>{
  HomePageBloc():super(HomePageState()){
    on<HomePageGetDataEvent>((event, emit) async{
          emit(await getVideo());
    });
    add(HomePageGetDataEvent());
    onScrollHandler();
}

 Future<HomePageState> getVideo()async{
    if(state.page !=null) {
      var res = await PlayerRepository().getList(state.page);
      state.page = res.links.next;
      state.videos.addAll(res.results);
      state.isDataLoaded=true;
    }
      return state.update(state);
  }

  onScrollHandler(){
    state.scrollController.addListener(() {
      if(state.scrollController.position.pixels ==
          state.scrollController.position.maxScrollExtent){
        add(HomePageGetDataEvent());
      }
    });
  }





}