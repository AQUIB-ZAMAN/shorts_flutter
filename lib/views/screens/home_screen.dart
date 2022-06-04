import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorts/views/screens/add_video_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> pages = [];
  late int pageIndex;
  void initState() {
    pageIndex = 0;
    pages = [
      Text('Home'),
      Text('Home'),
      AddVideoScreen(),
      Text('Home'),
      Text('Home'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        activeColor: Colors.red,
        inactiveColor: Colors.white,
        height: 0,
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
              Icons.add_box_rounded,
              size: 30,
            ),
            label: 'Home',
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
              Icons.tag_faces_outlined,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
