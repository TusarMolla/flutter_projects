import 'package:simple_video_player_app/events/event.dart';
import 'package:simple_video_player_app/player_list_response.dart';
class PassInitialValue extends Event{
  VideoInfo videoInfo;
  PassInitialValue(this.videoInfo);
}

class VideoLoaded extends Event{
  bool isLoaded;

  VideoLoaded(this.isLoaded);
}