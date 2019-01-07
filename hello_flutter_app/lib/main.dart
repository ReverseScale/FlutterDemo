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

  // Tab
  // runApp(MaterialApp(
  //   title: 'Tab',
  //   home: HomeState()
  // ));

  // 几种底部 Tabbar
  // runApp(TabbarTypeOne());

  // 路由动画
  runApp(RouterAnimationApp());

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
