import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorts/controllers/auth_controller.dart';
import 'package:shorts/utilities/const.dart';
import 'package:shorts/views/screens/add_video_screen.dart';
import 'package:shorts/views/screens/profile_screen.dart';
import 'package:shorts/views/screens/search_screen.dart';
import 'package:shorts/views/screens/video_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> pages = [
    VideoScreen(),
    SearchScreen(),
    AddVideoScreen(),
    Text('Home'),
    ProfileScreen(uid: authController.getUser!.uid),
  ];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 30,
            ),
            label: 'Add Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
            ),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
