// 引入 UI 库
import 'package:flutter/material.dart';

import 'package:hello_flutter_app/BasisApp.dart';
import 'package:hello_flutter_app/NavigationApp.dart';
import 'package:hello_flutter_app/ComplexApp.dart';
import 'package:hello_flutter_app/AnimationApp.dart';
import 'package:hello_flutter_app/TabApp.dart';
import 'package:hello_flutter_app/ChatsApp.dart';

// main 入口方法，进入 MyApp
// 单行调用使用 “=> 函数”
// void main() => runApp(MyApp());
void main() {
  // 基础组件
  // runApp(BasisApp(
  //   items: new List<String>.generate(1000, (i)=>"$i 号技师")
  // ));

  // 导航跳转
  // runApp(MaterialApp(title: '侧滑菜单', home: SlideMenu()));

  // UI 练习
  // runApp(MaterialApp(
  //   title: 'UI 练习',
  //   home: TravelHome()
  // ));

  // Tab
  runApp(MaterialApp(
    title: 'Tab',
    home: HomeState()
  ));

  // Chats
  // runApp(new FriendlychatApp());

  // 动画练习
  // runApp(MaterialApp(title: '动画练习', home: AnimationPage()));
  
}
