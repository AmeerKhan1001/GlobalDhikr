import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/utils.dart';
import 'package:global_dhikr_final/screens/authScreen.dart';
import 'package:global_dhikr_final/screens/globalCounter.dart';
import 'package:global_dhikr_final/screens/onboardingScreen.dart';
import 'package:global_dhikr_final/screens/personalCounter.dart';
import 'package:global_dhikr_final/screens/settingsScreen.dart';
import 'package:global_dhikr_final/screens/contactScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color primary = Colors.white;
final Color active = Colors.white;
final Color divider = Colors.grey.shade600;

buildDrawer(BuildContext context) {
  return ClipPath(
    clipper: OvalRightBorderClipper(),
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
//                buildRow(context,Icons.person_pin, "My profile",routeId: ProfileScreen.id),
//                buildDivider(),
                buildRow(context,Icons.perm_identity, "Personal Page",routeId: PersonalPage.id),
                buildDivider(),
                buildRow(context,Icons.people, "Global Page",routeId: GlobalPage.id),
                buildDivider(),
                buildRow(context,Icons.settings, "Settings",routeId: Settings.id),
                buildDivider(),
                buildRow(context,Icons.email, "Contact us",routeId: ContactScreen.id),
                buildDivider(),
                buildRow(context,Icons.info_outline, "Intro Screens",routeId: onBoardingScreen.id),
                buildDivider(),
                buildRow(context,Icons.remove_circle_outline, "Logout",routeId: AuthThreePage.id),
                buildDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider buildDivider() {
  return Divider(
    color: divider,
  );
}

Widget buildRow(BuildContext context, IconData icon, String title, {String routeId,FirebaseUser firebaseUser}) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
  return RaisedButton(
    color: Colors.purple,
    splashColor: Colors.purpleAccent,
    onPressed: () async {
      if(routeId == AuthThreePage.id) {
        await _googleSignIn.signOut();
        await _auth.signOut();
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('loggedIn', false);
      }
      Navigator.pushReplacementNamed(context, routeId);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
      ]),
    ),
  );
}

