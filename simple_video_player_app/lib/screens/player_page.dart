import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_video_player_app/blocs/player_block.dart';
import 'package:simple_video_player_app/device_info.dart';
import 'package:simple_video_player_app/events/player_page_event.dart';
import 'package:simple_video_player_app/screens/blank_page.dart';
import 'package:simple_video_player_app/states/player_page_state.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  PlayerBloc bloc = PlayerBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    context.read<PlayerBloc>().add(VideoLoaded(false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //Container(),
          BlocBuilder<PlayerBloc, PlayerPageState>(
              // bloc: bloc,
              builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 200,
                    width: DeviceInfo(this.context).width,
                    child: Stack(
                      children: [
                        YoYoPlayer(
                          aspectRatio: 16 / 9,
                          url: state.videoInfo?.manifest ?? "",
                          onVideoInitCompleted: (controller) {
                            controller.addListener(() {
                              print("controller.value.isInitialized ${controller.value.isInitialized}");
                              if (controller.value.isInitialized && !state.isVideoLoaded) {
                                print("is load");
                                context.read<PlayerBloc>().add(VideoLoaded(true));
                              }
                            });


                          },
                          videoStyle: VideoStyle(
                            playIcon: Icon(Icons.play_arrow),
                            pauseIcon: Icon(Icons.pause),
                            fullscreenIcon: Icon(Icons.fullscreen),
                            forwardIcon: Icon(Icons.skip_next),
                            backwardIcon: Icon(Icons.skip_previous),
                          ),
                          videoLoadingStyle: VideoLoadingStyle(),
                        ),
                        if (!state.isVideoLoaded)
                          Image.network(
                            state.videoInfo?.thumbnail ?? "",
                            fit: BoxFit.cover,
                          ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    state.videoInfo?.title ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    children: [
                      Text(
                        "${state.videoInfo?.viewers ?? ''} views",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Text(
                          ".",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      Text(
                        "${DateTime.now().compareTo(state.videoInfo?.dateAndTime ?? DateTime.now())} days ago",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        optionModel(Icons.favorite_border, "MASH ALLAH (12K)"),
                        const SizedBox(
                          width: 10,
                        ),
                        optionModel(Icons.thumb_up_alt_outlined, "LIKE (2K)"),
                        const SizedBox(
                          width: 10,
                        ),
                        optionModel(Icons.share, "SHARE"),
                        const SizedBox(
                          width: 10,
                        ),
                        optionModel(Icons.flag, "REPORT"),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BlankPage(title: "Channel")));
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          state.videoInfo?.channelImage ??
                                              ""))),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: DeviceInfo(context).width * 0.5,
                                  child: Text(
                                    state.videoInfo?.channelName ?? '',
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "${state.videoInfo?.channelSubscriber ?? 0} Subscribers",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.symmetric(horizontal: 10)),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 14,
                                color: Colors.white,
                              ),
                              Text(
                                "Subscribe",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        "Comments 7.5K",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Spacer(),
                      Icon(
                        Icons.unfold_more_outlined,
                        size: 16,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlankPage(title: "Comment")));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Text(
                          "Add Comment",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Spacer(),
                        Icon(
                          Icons.send_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                                    state.videoInfo?.channelImage ?? ""))),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: DeviceInfo(context).width * 0.7,
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Md. Tusar Molla',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '3 days ago',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: DeviceInfo(context).width - 74,
                            // padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: const Text(
                              "সে মুমিন নয়, যে নিজে পেট পূরে খায় আর পাশেই তার প্রতিবেশী না খেয়ে থাকে।” [বায়হাকী]",
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget optionModel(IconData icon, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 12,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
