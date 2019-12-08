import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Dhikr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: controller,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.people)),
            Tab(icon: Icon(Icons.perm_identity))
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[GlobalPage(), PersonalPage()],
      ),
    );
  }
}

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: new GestureDetector(
            onTap: () {
              setState(() {
                read_update_global_counters();
              });
            },
            child: InkWell(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(sortedCount[index].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                      Text(sortedDhikrList[index],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.all(20),
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            child: Text('Refresh Data'),
            onPressed: () {
              setState(() {
                read_update_global_counters();
              });
            },
          )
        ],
      ),
    );
  }
}

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: new GestureDetector(
            onTap: () {
              setState(() {
                inc_counter(index.toString());
              });
            },
            child: InkWell(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(personalMap[index.toString()].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                      Text(dhikr_text[index],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.all(20),
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            child: Text('Upload Data'),
            onPressed: () {
              setState(() {
                read_update_global_counters();
              });
            },
          )
        ],
      ),
    );
  }
}
