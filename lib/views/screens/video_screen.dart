import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/controllers/video_controller.dart';
import 'package:shorts/views/screens/comment_screen.dart';
import 'package:shorts/views/screens/widgets/circle_animation.dart';
import 'package:shorts/views/screens/widgets/videoplayeritem.dart';

import '../../utilities/const.dart';

class VideoScreen extends StatefulWidget {
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController videoController = Get.put(VideoController());

  buildMusicAlbum() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Color.fromARGB(255, 120, 118, 118),
            Colors.white,
            Colors.red,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      height: 56,
      width: 56,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: videoController.videoList.length, //Change later
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemBuilder: ((context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl),
                //Player video later,
                Column(children: [
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.username,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  data.caption,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.music_note,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.songName,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      videoController.likeVideo(data.id);
                                    },
                                    child: (data.likes
                                            .contains(auth.currentUser!.uid))
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 40,
                                          )
                                        : Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                  ),
                                  Text(data.likes.length.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return CommentScreen(
                                            postId: data.id,
                                            profilePic: data.profilePhoto);
                                      }))
                                    },
                                    child: Icon(
                                      Icons.comment,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  Text(data.commentCount.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.reply,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  Text(data.shareCount.toString()),
                                ],
                              ),
                              Stack(children: [
                                CircleAnimation(child: buildMusicAlbum()),
                                Positioned(
                                  left: 3.1,
                                  top: 3,
                                  child: Container(
                                    // ignore: sort_child_properties_last
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: (data.profilePhoto != null)
                                          ? Image.network(
                                              data.profilePhoto!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/defaultProfilePic.jpg'),
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ],
            );
          }),
        );
      }),
    );
  }
}
