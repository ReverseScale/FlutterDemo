import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ToDoList/root.dart';
import 'Travel/root.dart';
import 'SQList/root.dart';
import 'Chats/root.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.done),
              title: Text('To do List'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => RootApp()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.card_travel),
              title: Text('Travel'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TravelHome()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.data_usage),
              title: Text('Data base'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SQList()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FriendlychatApp()));
            },
          ),
        ],
      ),
    );
  }
}