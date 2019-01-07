import 'package:flutter/material.dart';

class TopHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopBar',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: TopBarHome(),
      ),
    );
  }
}
class TopBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('导航分栏'),
          elevation: 0.0,
          bottom: TabBar(
            indicatorColor: Colors.blue,
            tabs: <Widget>[
              Tab(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.code),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("代码"),
                ],
              )),
              Tab(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.query_builder),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("问题"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.merge_type),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("提交"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[EachPages('代码'), EachPages('问题'), EachPages('提交')],
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
      body: Center(
        child: Text(widget._title),
      ),
    );
  }
}
