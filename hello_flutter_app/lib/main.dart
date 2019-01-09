// 引入 UI 库
import 'package:flutter/material.dart';

import 'package:hello_flutter_app/BasisApp/root.dart';
import 'package:hello_flutter_app/NavigationApp/root.dart';
import 'package:hello_flutter_app/TravelApp/root.dart';
import 'package:hello_flutter_app/AnimationApp/root.dart';
import 'package:hello_flutter_app/TabChatsApp/TabApp.dart';
import 'package:hello_flutter_app/TabChatsApp/ChatsApp.dart';
import 'package:hello_flutter_app/TouchApp/root.dart';
import 'package:hello_flutter_app/SQListApp/DataApp.dart';
import 'package:hello_flutter_app/SQListApp/root.dart';
import 'package:hello_flutter_app/ToDoListApp/root.dart';
import 'package:hello_flutter_app/ButtomTabbarApp/root.dart';
import 'package:hello_flutter_app/CupertinoApp/root.dart';
import 'package:hello_flutter_app/RouterAnimationApp/root.dart';
import 'package:hello_flutter_app/FuzzyApp/root.dart';
import 'package:hello_flutter_app/TopBarApp/root.dart';
import 'package:hello_flutter_app/SearchAPP/root.dart';
import 'package:hello_flutter_app/FlowLayoutApp/root.dart';
import 'package:hello_flutter_app/ExpansionApp/root.dart';
import 'package:hello_flutter_app/BethelApp/root.dart';
import 'package:hello_flutter_app/LoadApp/root.dart';
import 'package:hello_flutter_app/GesturesBackApp/root.dart';

// main 入口方法，进入 MyApp
// 单行调用使用 “=> 函数”
// void main() => runApp(MyApp());
void main() {
  // 基础组件
  // runApp(BasisApp(
  //   items: new List<String>.generate(1000, (i)=>"$i 号技师")
  // ));

  // 导航跳转
  // runApp(MaterialApp(title: '导航', home: Navigation()));

  // 几种底部 Tabbar
  // runApp(TabbarTypeOne());

  // Tab 封装库
  // runApp(MaterialApp(
  //   title: 'Tab',
  //   home: HomeState()
  // ));

  // 顶部导航栏 Tabbar
  // runApp(TopHome());

  // 搜索栏
  // runApp(SearchApp());

  // 流式布局
  // runApp(FlowLayoutApp());

  // 展开闭合
  // runApp(ExpansionApp());

  // 贝塞尔曲线
  // runApp(BethelApp());

  // 加载图
  // runApp(LoadApp());

  // 侧滑手势返回
  runApp(GesturesBackApp());

  // 路由动画
  // runApp(RouterAnimationApp());

  // 毛玻璃模糊效果
  // runApp(FuzzyPage());

  // Chats
  // runApp(FriendlychatApp());

  // iOS/Android 风格组件
  // runApp(TabbarType());

  // 手势练习
  // runApp(MaterialApp(title: 'Touch', home: TouchState()));

  // 动画练习
  // runApp(MaterialApp(title: '动画练习', home: AnimationPage()));

  // 数据存储
  // runApp(MaterialApp(
  //   title: 'Data',
  //   home: SQList(),
  // ));

  // UI 练习: 旅行详情页
  // runApp(MaterialApp(
  //   title: 'UI 练习',
  //   home: TravelHome()
  // ));

  // UI 练习: ToDoList
  // runApp(RootApp());
}
