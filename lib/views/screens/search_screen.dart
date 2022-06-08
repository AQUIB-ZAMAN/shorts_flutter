import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/controllers/search_controller.dart';
import 'package:shorts/views/screens/profile_screen.dart';

import '../../models/user.dart';

class SearchScreen extends StatelessWidget {
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              onFieldSubmitted: (value) {
                searchController.searchUser(value);
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  )),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  )),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
            )),
        body: searchController.searchedUsers.isEmpty
            ? Center(
                child: Text('Search for users',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProfileScreen(uid: user.uid);
                      }));
                    },
                    child: ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: (user.profilePhoto != null)
                              ? Image.network(
                                  user.profilePhoto!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/defaultProfilePic.jpg'),
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
