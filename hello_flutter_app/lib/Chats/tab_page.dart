import 'package:flutter/material.dart';

import 'package:hello_flutter_app/BasisApp/root.dart';
// import 'package:bottom_tab_bar/bottom_tab_bar.dart';
import 'package:hello_flutter_app/Chats/root.dart';

import 'tabbar/bottom_tab_bar.dart';

class HomeTPage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

//用于使用到了一点点的动画效果，因此加入了SingleTickerProviderStateMixin
class _HomePageState extends State<HomeTPage>
    with SingleTickerProviderStateMixin {
  //定义底部导航项目
  final List<Tab> _bottomTabs = <Tab>[
    new Tab(
      text: 'Home',
      icon: new Icon(Icons.home),
    ), //icon和text的显示顺序已经内定，如需自定义，到child属性里面加吧
    new Tab(
      icon: new Icon(Icons.history),
      text: 'History',
    ),
    new Tab(
      icon: new Icon(Icons.book),
      text: 'Book',
    ),
  ];

  //定义底部导航Tab
  TabController _bottomNavigation;

  //初始化导航Tab控制器
  @override
  void initState() {
    super.initState();
    _bottomNavigation = new TabController(
        vsync: this, //动画处理参数
        length: _bottomTabs.length //控制Tab的数量
        ); //底部主导航栏控制器
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _bottomNavigation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepOrange,
          title: new Text('title'),
        ), //头部的标题AppBar
        drawer: new Drawer(
          //侧边栏按钮Drawer
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                //Material内置控件
                accountName: new Text('CYC'), //用户名
                accountEmail: new Text('example@126.com'), //用户邮箱
                currentAccountPicture: new GestureDetector(
                  //用户头像
                  onTap: () => print('current user'),
                  child: new CircleAvatar(//圆形图标控件
                      // backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),//图片调取自网络
                      ),
                ),
                otherAccountsPictures: <Widget>[
                  //粉丝头像
                  new GestureDetector(
                    //手势探测器，可以识别各种手势，这里只用到了onTap
                    onTap: () => print('other user'), //暂且先打印一下信息吧，以后再添加跳转页面的逻辑
                    child: new CircleAvatar(
                        // backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/10878817/240ab127-e41b-496b-80d6-fc6c0c99f291?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                        ),
                  ),
                  new GestureDetector(
                    onTap: () => print('other user'),
                    child: new CircleAvatar(
                        // backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                        ),
                  ),
                ],
                decoration: new BoxDecoration(
                  //用一个BoxDecoration装饰器提供背景图片
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    // image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
                    //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
                    image: new ExactAssetImage('images/lake.jpg'),
                  ),
                ),
              ),
              new ListTile(
                  //第一个功能项
                  title: new Text('First Page'),
                  trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => GridViewList()));
                  }),
              new ListTile(
                  //第二个功能项
                  title: new Text('Second Page'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => GridViewList()));
                  }),
              new ListTile(
                  //第二个功能项
                  title: new Text('Second Page'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/a');
                  }),
              new Divider(), //分割线控件
              new ListTile(
                //退出按钮
                title: new Text('Close'),
                trailing: new Icon(Icons.cancel),
                onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
              ),
            ],
          ),
        ),
        body: new TabBarView(controller: _bottomNavigation, children: [
          //注意顺序与TabBar保持一直
          new TabPage(),
          new TabPage(),
          new TabPage(),
        ]),
        bottomNavigationBar: new Material(
          color: Colors.deepOrange, //底部导航栏主题颜色
          child: new TabBar(
            controller: _bottomNavigation,
            tabs: _bottomTabs,
            indicatorColor: Colors.white, //tab标签的下划线颜色
          ),
        ));
  }
}

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.orangeAccent,
          title: new TabBar(
            tabs: [
              new Tab(icon: new Icon(Icons.directions_car)),
              new Tab(icon: new Icon(Icons.directions_transit)),
              new Tab(icon: new Icon(Icons.directions_bike)),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: Center(),
      ),
    );
  }
}


class HomeState extends StatefulWidget {
  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> with SingleTickerProviderStateMixin {

  TabController _tabController;
  int _selectedIndex = 1;
  String badgeNo1;
  var titles = ['home', 'video', 'find', 'smallvideo', 'my'];
  var icons = [
    Icons.home,
    Icons.play_arrow,
    Icons.child_friendly,
    Icons.fiber_new,
    Icons.mic_none
  ];
  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, initialIndex: 1, length: titles.length);
    badgeNo1 = '12';
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      badgeNo1 = '';
    });
  }

  final _widgetOptions = [
    FriendlychatApp(),
    Text('Index 1: Video'),
    Text('Index 2: find someone'),
    Text('Index 3: small Video'),
    Text('Index 4: My'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Tab Bar'),
      //   actions: <Widget>[new Icon(Icons.photo_camera)],
      // ),
      bottomNavigationBar: BottomTabBar(
        items: <BottomTabBarItem>[
          BottomTabBarItem(
              icon: Icon(icons[0]), title: Text(titles[0]), badgeNo: badgeNo1),
          BottomTabBarItem(icon: Icon(icons[1]), title: Text(titles[1])),
          BottomTabBarItem(icon: Icon(icons[2]), title: Text(titles[2])),
          BottomTabBarItem(
              icon: Icon(icons[3]),
              activeIcon: Icon(icons[3]),
              title: Text(titles[3])),
          BottomTabBarItem(icon: Icon(icons[4]), title: Text(titles[4])),
        ],
        fixedColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemSelected,
        type: BottomTabBarType.fixed,
        isAnimation: false,
        isInkResponse: false,
        badgeColor: Colors.green,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
