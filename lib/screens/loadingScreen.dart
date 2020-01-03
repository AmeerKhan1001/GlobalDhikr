import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/data.dart';
import 'package:global_dhikr_final/screens/onboardingScreen.dart';
import 'package:global_dhikr_final/screens/personalCounter.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  bool loggedIn;

  @override
  void initState() {
    super.initState();
    loadData().then((loggedIn) {
      setState(() {print('LoggedIn: $loggedIn');this.loggedIn = loggedIn;});
    });
  }

  Future loadData() async {
    // load your data from SharedPreferences
    await loadLang();
    await loadAllDhikr();
    await loadAllSalawat();
    loggedIn = await loadUser();
    return loggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return loggedIn != null ? ( loggedIn ? PersonalPage() : onBoardingScreen() ) : Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Loading...',style: TextStyle(color: Colors.purple,fontSize: 20)),
            Container(child: CircularProgressIndicator(),margin: EdgeInsets.all(20)),
          ],
        ),
      ),
    );
  }
}






