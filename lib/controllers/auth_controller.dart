import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/models/user.dart' as model;
import 'package:shorts/views/screens/auth/login_screen.dart';

import '../utilities/const.dart';
import '../views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  //Rx implies the user can change them and these changes are reflected instantaneously
  Rx<File?>? _pickedImage = null;

  //save the state of the user
  late Rx<User?> user;
  @override
  // onReady() -> automaticalyy executed when the app is launched and ready to start
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.authStateChanges());
    ever(user, setInitialState);
  }

  setInitialState(User? user) {
    if (user == null) {
      Get.offAll(LoginScreen());
    } else {
      Get.offAll(HomeScreen());
    }
  }

  Stream<User?> get authChanges => auth.authStateChanges();

  // User? get user => auth.currentUser;

  File? get profilePhoto => _pickedImage?.value ?? null;

  File? setProfilepic() => _pickedImage = null;

  //function to pick image from the gallery
  void pickImage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 60);

    // check if user has picked an image or not
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

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar(
          'Error sigining in ',
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
        'Error signing into account',
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
