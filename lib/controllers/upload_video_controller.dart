import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_compress/video_compress.dart';

import '../models/video.dart';
import '../utilities/const.dart';

class UploadVideoController {
  //function to compress video before storing
  compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  //uploading video to storage

  Future<String> uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref('videos').child(id);
    UploadTask uploadTask = ref.putFile(await compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //generating thumbnail
  getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      //retrieve the video and compress it
      var allDocs = await firestore.collection('videos').get();

      int length = allDocs.docs.length;
      var videoUrl = await uploadVideoToStorage('videos $length', videoPath);
      var thumbnailUrl =
          await uploadImageToStorage('videos $length', videoPath);

      //save video to firebase db
      Video video = Video(
        username: (userDoc.data() as Map<String, dynamic>)['name'],
        uid: uid,
        id: 'videos $length',
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnailUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      await firestore
          .collection('videos')
          .doc('videos $length')
          .set(video.toJson());

      //take the user back to the previous page
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error uploading video',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
