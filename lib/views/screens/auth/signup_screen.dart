import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:shorts/utilities/const.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController username = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  void initState() {
    authController.setProfilepic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          // alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: [
                    CircleAvatar(
                        radius: 100,
                        // backgroundImage: authController.profilePhoto == null
                        //     ? NetworkImage(
                        //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU')
                        //     : null,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                            radius: 98,
                            child: ClipOval(
                              child: (authController.profilePhoto != null)
                                  ? Image.file(
                                      authController.profilePhoto!,
                                      width: 196,
                                      height: 196,
                                      fit: BoxFit.contain,
                                    )
                                  : Image.asset(
                                      'assets/images/defaultProfilePic.jpg'),
                            ))),
                    Positioned(
                      bottom: -10,
                      left: 150,
                      child: IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            authController.pickImage();
                            setState(() {});
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: username,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.white,
                    hintText: 'Username',
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
                  obscureText: true,
                  obscuringCharacter: '*',
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
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => authController.registerUser(username.text,
                    email.text, password.text, authController.profilePhoto),
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.all(8),
                    child: Text(
                      'Register',
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
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Login.",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
