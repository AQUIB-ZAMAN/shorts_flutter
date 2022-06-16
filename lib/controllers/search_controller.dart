import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts/utilities/const.dart';

import '../models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _seachedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _seachedUsers.value;

  searchUser(String typedUser) async {
    _seachedUsers.bindStream(await firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var element in query.docs) {
        retVal.add(User.fromSnap(element));
      }
      return retVal;
    }));
  }
}
