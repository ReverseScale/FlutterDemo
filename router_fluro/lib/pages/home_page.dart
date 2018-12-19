import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: ListView(
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'root');
                },
                child: Text('I\'m back!.')),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'about');
                },
                child: Text('About'))
          ],
        ));
  }
}
