import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String username;
  final String uid;
  final String id;
  final List likes;
  final String songName;
  final String caption;
  final int commentCount;
  final int shareCount;
  final String videoUrl;
  final String thumbnail;
  String? profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    this.profilePhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'songName': songName,
      'caption': caption,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'profilePhoto': profilePhoto,
    };
  }

  // define how the data is going to be stored in the database
  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      username: snapshot['username'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      thumbnail: snapshot['thumbnail'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
