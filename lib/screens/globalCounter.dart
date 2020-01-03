import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/data.dart';
import 'package:global_dhikr_final/models/drawerWidget.dart';
import 'package:global_dhikr_final/models/onWillPop.dart';

class GlobalPage extends StatefulWidget {
  static String id = 'globalcounter_screen';
  @override
  _GlobalPageState createState() { return _GlobalPageState(); }
}

class _GlobalPageState extends State<GlobalPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text('Global Page'),
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
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                itemCount: globalSalawatListEng.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    shape: BeveledRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    child: ListTile(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: AnimatedCount(count: globalSalawatCountList[index],duration: Duration(seconds: 3)),
                        title: Text(getSalawatList()[index],
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: globalDhikrListEng.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    shape: BeveledRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    child: ListTile(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: AnimatedCount(count: globalDhikrCountList[index],duration: Duration(seconds: 3)),
                        title: Text(getDhikrList()[index],
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () async {
              bool done = await refreshDhikrGlobalCounters();
              setState(() {});
            },
            child: Container(
                child: Center(
                  child: Text('Refresh Data',
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
      ),
    );
  }
}

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final int count;

  AnimatedCount(
      {Key key,
      @required this.count,
      @required Duration duration,
      Curve curve = Curves.linear})
      : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _count;

  @override
  Widget build(BuildContext context) {
    return new Text(_count.evaluate(animation).toString(),
        style: TextStyle(
        color: Colors.brown,
        fontSize: 24.0,
        fontWeight: FontWeight.bold));
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _count = visitor(
        _count, widget.count, (dynamic value) => new IntTween(begin: value));
  }
}
