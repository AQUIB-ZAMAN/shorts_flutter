import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts/utilities/const.dart';

import '../models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  //getter
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retValue = [];
      for (var element in query.docs) {
        retValue.add(Video.fromSnap(element));
      }
      return retValue;
    }));
  }

  likeVideo(String id) async {
    String uid = authController.getUser!.uid;
    final doc = await firestore.collection('videos').doc(id).get();
    if ((doc.data() as Map<dynamic, dynamic>)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
