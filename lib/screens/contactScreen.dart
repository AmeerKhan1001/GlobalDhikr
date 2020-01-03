import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/drawerWidget.dart';
import 'package:global_dhikr_final/models/onWillPop.dart';

class ContactScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  static String id = 'contact_screen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('Contact Us'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
        ),
        drawer: buildDrawer(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('For queries - Message us at Abdellah.haroune@hotmail.com',style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
