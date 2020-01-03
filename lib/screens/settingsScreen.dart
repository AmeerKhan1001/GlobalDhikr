import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/drawerWidget.dart';
import 'package:global_dhikr_final/screens/personalCounter.dart';
import 'package:global_dhikr_final/models/data.dart';
import 'package:global_dhikr_final/models/onWillPop.dart';

class Settings extends StatefulWidget {
  static String id = 'settings_screen';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Color _getButtonColor({int buttonNumber}) {
    return tempEngLang
        ? (buttonNumber == 1 ? Colors.indigoAccent : Colors.black)
        : (buttonNumber == 1 ? Colors.black : Colors.indigoAccent);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('Settings'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
        ),
        drawer: buildDrawer(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Select the language of the dhikr',
                style: TextStyle(fontSize: 20)),
            Container(margin: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    changeLang(true);
                    setState(() {});
                  },
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: _getButtonColor(buttonNumber: 1),
                  child: new Text("English"),
                ),
                new RaisedButton(
                  onPressed: () {
                    changeLang(false);
                    setState(() {});
                  },
                  textColor: Colors.white,
                  color: _getButtonColor(buttonNumber: 2),
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Arabic",
                  ),
                ),
              ],
            ),
            Container(margin: EdgeInsets.all(10)),
            Text('Then press save and continue',
                style: TextStyle(fontSize: 20)),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, PersonalPage.id);
          },
          child: Container(
              child: Center(
                child: Text('Save and Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold)),
              ),
              color: Colors.black,
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 60),
        ),
      ),
    );
  }
}
