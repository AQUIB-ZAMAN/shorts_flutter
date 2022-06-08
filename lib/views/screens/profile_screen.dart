import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;

  ProfileScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
