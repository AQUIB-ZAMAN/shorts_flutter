import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/models/user.dart' as model;

import '../utilities/const.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<File?>? _pickedImage = null;

  Stream<User?> get authChanges => auth.authStateChanges();
  User? get user => auth.currentUser;

  File? get profilePhoto => _pickedImage?.value ?? null;

  //function to pick image from the gallery
  void pickImage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (pickedImage != null) {
      _pickedImage = Rx<File?>(File(pickedImage.path));
      Get.snackbar(
        'Profile Picture',
        'Congratulations your image has been uploaded.',
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

  //uploading image to firebase storage
  Future<String> uploadImageToStorage(File image) async {
    Reference ref =
        firebaseStorage.ref().child('profilePic').child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //registering users with email and password
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // && image!=null
        // we want to save user to auth, firebase
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        var downloadUrl;
        if (image != null) {
          downloadUrl = await uploadImageToStorage(image);
        }

        model.User user = model.User(
            name: username,
            profilePhoto: downloadUrl,
            email: email,
            uid: auth.currentUser!.uid);

        await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields.',
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
    } catch (e) {
      Get.snackbar(
        'Error creating account',
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
