import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  //
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ConfirmScreen(
            videoFile: File(video.path), videoPath: video.path);
      }));
    }
  }

  showDialogOption(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.gallery, context),
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gallery',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.camera, context),
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Camera',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(),
                child: Row(
                  children: [
                    Icon(Icons.cancel),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            width: 190,
            height: 50,
            child: Text(
              'Add Video.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onTap: () => showDialogOption(context),
        ),
      ),
    );
  }
}
