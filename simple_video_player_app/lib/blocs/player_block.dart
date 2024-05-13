import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_video_player_app/events/player_page_event.dart';
import 'package:simple_video_player_app/player_list_response.dart';
import 'package:simple_video_player_app/states/player_page_state.dart';
import '../events/event.dart';

class PlayerBloc extends Bloc<Event,PlayerPageState>{

  PlayerBloc():super(PlayerPageState()){
    on<VideoLoaded>((event, emit) {
      state.isVideoLoaded = event.isLoaded;
      return emit(state.update(state));
    });
    on<PassInitialValue>((event, emit) {
      state.videoInfo = event.videoInfo;
      state.isVideoLoaded = false;
      return emit(state.update(state));
    });
  }

}