import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/data.dart';
import 'package:global_dhikr_final/models/onWillPop.dart';
import 'package:global_dhikr_final/models/drawerWidget.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class PersonalPage extends StatefulWidget {
  static String id = 'personalcounter_screen';

  @override
  _PersonalPageState createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return onWillPop(context);
        },
        child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text('Personal Page'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _key.currentState.openDrawer();
              },
            ),
            bottom: TabBar(tabs: <Widget>[
              Container(child: Text('Salawat',style: TextStyle(fontSize: 20)),padding: EdgeInsets.all(5)),
              Container(child: Text('Dhikr',style: TextStyle(fontSize: 20)),padding: EdgeInsets.all(5))
            ],),
          ),
          drawer: buildDrawer(context),
          resizeToAvoidBottomPadding: false,
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                itemCount: globalSalawatListEng.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: InkWell(
                    child: Card(
                      shape: BeveledRectangleBorder(
                        side: BorderSide(color: Colors.black,width: 3),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Text(
                              personalSalawatMap[index.toString()].toString(),
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold)
                          ),
                          title: Text(getSalawatList()[index],
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)
                          )
                      ),
                    ),
                    onTap: () async {
                      int temp = await _asyncInputDialog(context);
                      setState(() {
                        setCounter(index.toString(),value: temp,dhikr: false);
                      });
                    },
                  ),
                ),
              ),
              ListView.builder(
                itemCount: globalDhikrListEng.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: InkWell(
                    child: Card(
                      shape: BeveledRectangleBorder(
                        side: BorderSide(color: Colors.black,width: 3),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Text(
                              personalDhikrMap[index.toString()].toString(),
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold)
                          ),
                          title: Text(getDhikrList()[index],
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)
                          )
                      ),
                    ),
                    onTap: () async {
                      int temp = await _asyncInputDialog(context);
                      setState(() {
                        setCounter(index.toString(),value: temp);
                      });
                    },
                  ),
                ),
              )
            ] ,
          ),
            bottomNavigationBar: GestureDetector(
              onTap: () async {
                await uploadCounters();
                setState(() {});
              },
              child: Container(
                  child: Center(
                    child: Text('Upload Data',
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
            )
        ),
      ),
    );
  }
}

Future<int> _asyncInputDialog(BuildContext context) async {
  int value ;
  return showDialog<int>(
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Dhikr Made'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                      labelText: 'Count'),
                  onChanged: (value1) {
                    value = int.parse(value1);
                  },
                ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(value);
            },
          ),
        ],
      );
    },
  );
}