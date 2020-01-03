import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_dhikr_final/screens/settingsScreen.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:global_dhikr_final/screens/authScreen.dart';
import 'package:global_dhikr_final/models/onWillPop.dart';

class onBoardingScreen extends StatelessWidget {

  static String id = 'onboarding_screen';
  final _auth = FirebaseAuth.instance;

  final pages = [
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      bubbleBackgroundColor: Colors.indigo,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Welcome to Global Dhikr'),
          Text(
            'The place where you can view the global count of dhikr and salawat made.',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
            ),
          ),
        ],
      ),
      mainImage: Image.asset(
        'images/earth.jpg',
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: Colors.indigo,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Simple and Easy to use'),
          Text(
            'The Messenger (peace and blessings of Allah be upon him) taught us that tasbeeh with the fingers is better, as he said, '
                '‘Count with the fingertips, for they will be made to speak.‘',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
            ),
          ),
          Text(
            'Hence after recitation of your dhikr , simply tap to enter the count on the personal page and click upload',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
            ),
          )
        ],
      ),
      mainImage: Image.asset(
        'images/lamp.jpg',
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: Colors.indigo,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Global Contribution'),
          Text(
            'After uploading , head on to the global page and refresh to see the global dhikr count',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
            ),
          ),
        ],
      ),
      mainImage: Image.asset(
        'images/tree.jpg',
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context,toExit: true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              IntroViewsFlutter(
                pages,
                onTapDoneButton: () async {
                  print('onboarding');
                  FirebaseUser user = await _auth.currentUser();
                  print(user);
                  user == null ? Navigator.pushReplacementNamed(context, AuthThreePage.id) : Navigator.pushReplacementNamed(context, Settings.id);
                },
                showSkipButton: false,
                doneText: Text("Get Started",),
                pageButtonsColor: Colors.indigo,
                pageButtonTextStyles: new TextStyle(
                  // color: Colors.indigo,
                  fontSize: 16.0,
                  fontFamily: "Regular",
                ),
              ),
//            Positioned(
//                top: 20.0,
//                left: MediaQuery.of(context).size.width/2 - 50,
//                child: Image.asset('assets/smwallet/logo.png', width: 100,)
//            )
            ],
          ),
        ),
      ),
    );
  }
}