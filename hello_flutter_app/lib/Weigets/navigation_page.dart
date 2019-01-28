import 'package:flutter/material.dart';

import 'custom_router.dart';

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Navigation',
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
              leading: Icon(Icons.navigate_next),
              title: Text('Pass value'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PassValuePage()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.call_split),
              title: Text('Router animation'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => RouterHome()));
            },
          ),
        ],
      ),
    );
  }
}

class PassValuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '技师列表',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('查看技师资料'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondScreenPage()));
            },
          ),
        ));
  }
}

class SecondScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '技师资料',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

// 技师类
class Product {
  final String title;
  final String description;

  Product(this.title, this.description);
}


class RouterHome extends StatefulWidget {
  @override
  _RouterHomeState createState() => _RouterHomeState();
}

class _RouterHomeState extends State<RouterHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 26.0),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 46.0,
          ),
          onPressed: () {
            Navigator.of(context)
                // .push(MaterialPageRoute(builder: (BuildContext context) {
                .push(CustomRouter(EachPages('Next')));
          },
        ),
      ),
    );
  }
}

// 动态子页面
class EachPages extends StatefulWidget {
  String _title;
  EachPages(this._title);
  @override
  _EachPagesState createState() => _EachPagesState();
}

class _EachPagesState extends State<EachPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text(
          widget._title,
          style: TextStyle(color: Colors.white, fontSize: 26.0),
        ),
        backgroundColor: Colors.pinkAccent,
        leading: Container(),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(
            Icons.navigate_before,
            color: Colors.white,
            size: 46.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
