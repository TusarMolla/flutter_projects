import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_video_player_app/player_list_response.dart';

class PlayerRepository{
 Future<PlayerListResponse> getList(page)async{
  var uri = Uri.parse("https://test-ximit.mahfil.net/api/trending-video/1?page=$page");

  var header = {
   "Content-Type":"application/json",
   "Vary": "Accept, Origin, Cookie",
   "Accept": "*/*",
  };
  var response = await http.get(uri,headers: header);
  return playerListResponseFromJson(utf8.decode(response.bodyBytes));

  }


}