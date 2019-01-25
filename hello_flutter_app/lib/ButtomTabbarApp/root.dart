import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TabbarTypeOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 基础 底部导航栏
      // home: TabbarStyleApp(),

      // 两种平台风格 底部导航栏
      home: BottomBarApp(),

      // 自定义样式 底部工具栏
      // home: CustomTabBarApp(),

      title: 'BottomTabBar',
      // theme: ThemeData.light(),
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
    );
  }
}

// 第三种方式
class CustomTabBarApp extends StatefulWidget {
  @override
  _CustomTabBarAppState createState() => _CustomTabBarAppState();
}

class _CustomTabBarAppState extends State<CustomTabBarApp> {
  int _index = 0;
  List<Widget> list = List();
  Color defaultTabOneColor = Colors.blueGrey[200];
  Color selectedTabOneColor = Colors.white;

  Color _tabOneColor = Colors.white;
  Color _tabTwoColor = Colors.blueGrey[200];

  @override
  void initState() {
    super.initState();
    list..add(EachPages('Roter'))..add(EachPages('GPS'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return EachPages('Add');
          }));
        },
        tooltip: '长按我干啥',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: list[_index],
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: tabs(),
      ),
    );
  }

  Row tabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.near_me),
          color: _tabOneColor,
          onPressed: () {
            setState(() {
              _tabOneColor = selectedTabOneColor;
              _tabTwoColor = defaultTabOneColor;
              _index = 0;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.edit_location),
          color: _tabTwoColor,
          onPressed: () {
            setState(
              () {
                _tabOneColor = defaultTabOneColor;
                _tabTwoColor = selectedTabOneColor;
                _index = 1;
              },
            );
          },
        ),
      ],
    );
  }
}

// 第二种方式
class BottomBarApp extends StatefulWidget {
  @override
  _BottomBarAppState createState() => _BottomBarAppState();
}

class _BottomBarAppState extends State<BottomBarApp> {
  int _index = 0;
  Color _bottomNavigationColor = Colors.blue;
  final List<Widget> _childrenList = [Pageone(), Pagetwo(), Pagethree()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childrenList[_index],
      // Android 风格
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              title: Text(
                'Home',
                style: TextStyle(color: _bottomNavigationColor),
              ),
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              )),
          BottomNavigationBarItem(
              title: Text('Email',
                  style: TextStyle(color: _bottomNavigationColor)),
              icon: Icon(
                Icons.email,
                color: _bottomNavigationColor,
              )),
          BottomNavigationBarItem(
              title: Text('Game',
                  style: TextStyle(color: _bottomNavigationColor)),
              icon: Icon(
                Icons.videogame_asset,
                color: _bottomNavigationColor,
              )),
        ],
      ),

      // iOS 风格
      // bottomNavigationBar: CupertinoTabBar(
      //   currentIndex: _index,
      //   onTap: onTabTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //         title: Text(
      //           'Home',
      //           style: TextStyle(color: _bottomNavigationColor),
      //         ),
      //         icon: Icon(
      //           Icons.home,
      //           color: _bottomNavigationColor,
      //         )),
      //     BottomNavigationBarItem(
      //         title: Text('Email',
      //             style: TextStyle(color: _bottomNavigationColor)),
      //         icon: Icon(
      //           Icons.email,
      //           color: _bottomNavigationColor,
      //         )),
      //     BottomNavigationBarItem(
      //         title: Text('Airplay',
      //             style: TextStyle(color: _bottomNavigationColor)),
      //         icon: Icon(
      //           Icons.airplay,
      //           color: _bottomNavigationColor,
      //         )),
      //   ],
      // ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}

// 第一种方式
class TabbarStyleApp extends StatefulWidget {
  @override
  _TabbarStyleAppState createState() => _TabbarStyleAppState();
}

class _TabbarStyleAppState extends State<TabbarStyleApp>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: <Widget>[Pageone(), Pagetwo(), Pagethree()],
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: 'aaa',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'bbb',
              icon: Icon(Icons.list),
            ),
            Tab(
              text: 'ccc',
              icon: Icon(Icons.message),
            ),
          ],
          indicatorWeight: 0.1,
        ),
      ),
    );
  }
}

// 静态子页面
class Pageone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: CupertinoButton(
          child: Text('我爸是苹果'),
          color: Colors.lightBlue,
          padding: const EdgeInsets.all(10),
          onPressed: () {
            print('你点我干撒');
            showDialog(
              context: context,
              child: CupertinoAlertDialog(
                title: Column(
                  children: <Widget>[
                    Text('abc'),
                    Icon(Icons.favorite, color: Colors.red)
                  ],
                ),
                content: Text('enn...你点我干撒'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('抱歉'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('点你咋地'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Pagetwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Text('02'),
    );
  }
}

class Pagethree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Text('03'),
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
      appBar: AppBar(title: Text(widget._title),),
      body: Center(
        child: Text(widget._title),
      ),
    );
  }
}