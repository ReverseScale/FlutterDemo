import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tabbar',
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
              leading: Icon(Icons.tab_unselected),
              title: Text('Normal bottom bar'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TabbarStyleApp()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.android),
              title: Text('Android bottom bar'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarApp()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.free_breakfast),
              title: Text('Apple bottom bar'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarCupertinoApp()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.opacity),
              title: Text('Custom bottom bar'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CustomTabBarApp()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.border_top),
              title: Text('Nested top bar'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TopBarHome()));
            },
          ),
        ],
      ),
    );
  }
}

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

class BottomBarCupertinoApp extends StatefulWidget {
  @override
  _BottomBarCupertinoAppState createState() => _BottomBarCupertinoAppState();
}

class _BottomBarCupertinoAppState extends State<BottomBarCupertinoApp> {
  int _index = 0;
  Color _bottomNavigationColor = Colors.blue;
  final List<Widget> _childrenList = [Pageone(), Pagetwo(), Pagethree()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childrenList[_index],
      // iOS 风格
      bottomNavigationBar: CupertinoTabBar(
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
              title: Text('Airplay',
                  style: TextStyle(color: _bottomNavigationColor)),
              icon: Icon(
                Icons.airplay,
                color: _bottomNavigationColor,
              )),
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
              title:
                  Text('Game', style: TextStyle(color: _bottomNavigationColor)),
              icon: Icon(
                Icons.videogame_asset,
                color: _bottomNavigationColor,
              )),
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
    return Container(
      color: Colors.lightBlue,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(
            controller: controller,
            children: <Widget>[Pageone(), Pagetwo(), Pagethree()],
          ),
          bottomNavigationBar: Material(
            color: Colors.lightBlue,
            child: TabBar(
              controller: controller,
              tabs: <Widget>[
                Tab(
                  text: 'Page one',
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: 'Page two',
                  icon: Icon(Icons.list),
                ),
                Tab(
                  text: 'Page three',
                  icon: Icon(Icons.message),
                ),
              ],
              indicatorWeight: 0.1,
            ),
          ),
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
        title: Text(
          'Page one',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
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
        title: Text(
          'Page two',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Text('Page two'),
      ),
    );
  }
}

class Pagethree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page three',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Text('Page three'),
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
      appBar: AppBar(
        title: Text(
          widget._title,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Text(widget._title),
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
          title: Text(
            '导航分栏',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          bottom: TabBar(
            indicatorColor: Colors.blue,
            tabs: <Widget>[
              Tab(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.code,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "代码",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
              Tab(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.query_builder,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "问题",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.merge_type,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "提交",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TopEachPage('代码'),
            TopEachPage('问题'),
            TopEachPage('提交')
          ],
        ),
      ),
    );
  }
}

class TopEachPage extends StatefulWidget {
  String _title;
  TopEachPage(this._title);
  @override
  _TopEachPageState createState() => _TopEachPageState();
}

class _TopEachPageState extends State<TopEachPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget._title),
      ),
    );
  }
}
