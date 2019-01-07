import 'package:flutter/material.dart';
import 'custom_router.dart';

class RouterAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Router Animation',
      theme: ThemeData.light(),
      home: RouterHome(),
    );
  }
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
          style: TextStyle(fontSize: 26.0),
        ),
        elevation: 0.0,
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
          style: TextStyle(fontSize: 26.0),
        ),
        backgroundColor: Colors.pinkAccent,
        leading: Container(),
        elevation: 0.0,
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
