import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter_app/CupertinoApp/switches_page.dart';
import 'package:hello_flutter_app/CupertinoApp/dialogs_page.dart';


class TabbarType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CuperHomeApp(),
    );
  }
}

class CuperHomeApp extends StatefulWidget {
  @override
  _CuperHomeAppState createState() => _CuperHomeAppState();
}

class _CuperHomeAppState extends State<CuperHomeApp> {
  int _index = 0;
  final List<Widget> _children = [SwitchesPage(),DialogsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_index],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _index,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(title: Text('Switches'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('Switches'), icon: Icon(Icons.list)),
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

