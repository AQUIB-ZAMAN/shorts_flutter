import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/utilities/const.dart';

import '../models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _commentList = Rx<List<Comment>>([]);
  String postId = '';
  String? currPp = '';

  updatePostId(String id) {
    postId = id;
    getComment();
    getProfilePic();
  }

  getProfilePic() async {
    var userDoc =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    currPp = (userDoc.data() as Map<String, dynamic>)['profilePhoto'] as String;
  }

  getComment() async {
    _commentList.bindStream(firestore
        .collection('videos')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retValue = [];
      for (var element in query.docs) {
        retValue.add(
          Comment.fromSnap(element),
        );
      }
      return retValue;
    }));
  }

  //getter
  List<Comment> get commentList => _commentList.value;

  postComment(String commentText) async {
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      //retrieve the video and compress it
      var allDocs = await firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .get();

      int length = allDocs.docs.length;

      Comment comment = Comment(
        username: (userDoc.data() as Map<String, dynamic>)['name'],
        comment: commentText,
        datePublished: DateTime.now(),
        profilePhoto: (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
        likes: [],
        uid: uid,
        id: 'comment $length',
      );

      await firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc('comment $length')
          .set(comment.toJson());

      //update commentCount for current post
      DocumentSnapshot doc =
          await firestore.collection('videos').doc(postId).get();
      await firestore.collection('videos').doc(postId).update({
        'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
      });
    } catch (e) {
      // TODO
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

  likeComment(String id) async {
    var uid = authController.getUser!.uid;
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(postId)
        .collection('comments')
        .doc(id)
        .get();

    if (await (doc.data() as Map<String, dynamic>)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
