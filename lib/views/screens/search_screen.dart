import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
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
      body: Center(
        child: Text('Search for users',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}
