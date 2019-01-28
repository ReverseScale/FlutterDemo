import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'weiget_page.dart';
import 'demo_page.dart';

class RootHomeBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomBar(),
      title: 'BottomTabBar',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _index = 0;
  Color _bottomNavigationColor = Colors.blue;
  final List<Widget> _childrenList = [WeigetPage(), DemoPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childrenList[_index],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _index,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              title: Text('Widget',
                  style: TextStyle(color: _bottomNavigationColor)),
              icon: Icon(
                Icons.apps,
                color: _bottomNavigationColor,
              ),
            ),
          BottomNavigationBarItem(
              title: Text('Demo',
                  style: TextStyle(color: _bottomNavigationColor)),
              icon: Icon(
                Icons.local_pizza,
                color: _bottomNavigationColor,
              ),
            ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}