import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String username;
  final String comment;
  final datePublished;
  final List likes;
  String? profilePhoto;
  final String uid;
  final String id;

  Comment({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likes,
    this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'comment': comment,
      'datePublished': datePublished,
      'likes': likes,
      'profilePhoto': profilePhoto,
      'uid': uid,
      'id': id,
    };
  }

  // define how the data is going to be stored in the database
  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comment(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
