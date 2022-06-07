class User {
  String name;
  String? profilePhoto;
  String email;
  String uid;

  User(
      {required this.name,
      this.profilePhoto,
      required this.email,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profilePhoto': profilePhoto,
      'email': email,
      'uid': uid,
    };
  }

  static User fromSnap(DocumentSnap, snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapShot['name'],
      profilePhoto: snapShot['profilePhoto'],
      email: snapShot['email'],
      uid: snapShot['uid'],
    );
  }
}
