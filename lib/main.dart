import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/data.dart';
import 'package:global_dhikr_final/screens/globalCounter.dart';
import 'package:global_dhikr_final/screens/loadingScreen.dart';
import 'package:global_dhikr_final/screens/onboardingScreen.dart';
import 'package:global_dhikr_final/screens/personalCounter.dart';
import 'package:global_dhikr_final/screens/settingsScreen.dart';
import 'screens/contactScreen.dart';
import 'screens/profileScreen.dart';
import 'screens/authScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.purple, // navigation bar color
    statusBarColor: Colors.purple, // status bar color
  ));
  runApp(MyApp());
}



class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Dhikr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoadingScreen(),
      routes: {
        onBoardingScreen.id : (context) => onBoardingScreen(),
        AuthThreePage.id : (context) => AuthThreePage(),
        PersonalPage.id : (context) => PersonalPage(),
        GlobalPage.id : (context) => GlobalPage(),
        Settings.id : (context) => Settings(),
        ContactScreen.id : (context) => ContactScreen(),
        ProfileScreen.id : (context) => ProfileScreen()

      }
    );
  }
}


