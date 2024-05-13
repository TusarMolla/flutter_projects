import 'package:simple_video_player_app/player_list_response.dart';

class PlayerPageState {
  VideoInfo? videoInfo;
  bool isVideoLoaded = false;
  PlayerPageState({this.videoInfo});


 PlayerPageState update(PlayerPageState state){
    PlayerPageState pageState=  PlayerPageState();
    pageState.videoInfo = state.videoInfo;
    pageState.isVideoLoaded = state.isVideoLoaded;
    return pageState;

  }

}