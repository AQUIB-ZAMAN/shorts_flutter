import 'package:flutter/material.dart';
import 'package:shorts/utilities/const.dart';
import 'package:shorts/views/screens/auth/signup_screen.dart';
import 'package:shorts/views/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              children: [
                Text(
                  'Welcome...',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_rounded),
                fillColor: Colors.white,
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                fillColor: Colors.white,
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              authController.loginUser(email.text, password.text);
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.all(8),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SignupScreen();
                  }));
                },
                child: Text(
                  "Register .",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
