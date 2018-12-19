import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ohh, Router!'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text('Let\'s go to home page!'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, 'about');
              },
              child: Text('About')),
        ],
      ),
    );
  }
}
