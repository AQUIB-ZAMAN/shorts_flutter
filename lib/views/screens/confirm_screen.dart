import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/controllers/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  ConfirmScreen({
    required this.videoFile,
    required this.videoPath,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final uploadVideoController = Get.put(UploadVideoController());
  late TextEditingController songName;
  late TextEditingController caption;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: VideoPlayer(controller),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: songName,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.audiotrack),
                  hintText: 'Song Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(height: 10),
            TextField(
              controller: caption,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.closed_caption),
                hintText: 'Caption',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => uploadVideoController.uploadVideo(
                  songName.text, caption.text, widget.videoPath),
              child: Text('Share'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 18),
                primary: Colors.red,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
