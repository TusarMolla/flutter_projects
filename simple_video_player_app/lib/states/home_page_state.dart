

import 'package:flutter/material.dart';
import 'package:simple_video_player_app/player_list_response.dart';

class HomePageState{
  int? page =1;
  List<VideoInfo> videos =[];
  bool isDataLoaded = false;
  ScrollController scrollController = ScrollController();

HomePageState update(HomePageState homePageState){
  var state = HomePageState();
  state.page = homePageState.page;
  state.scrollController = homePageState.scrollController;
  state.videos = homePageState.videos;
  state.isDataLoaded=homePageState.isDataLoaded;
  return state;


}
}