// 引入 UI 库
import 'package:flutter/material.dart';

import 'package:hello_flutter_app/BasisApp/root.dart';
import 'package:hello_flutter_app/CupertinoApp/root.dart';
import 'package:hello_flutter_app/LoadApp/root.dart';
import 'package:hello_flutter_app/ExtendedTabs/root.dart';

import 'root_home.dart';

// main 入口方法，进入 MyApp
// 单行调用使用 “=> 函数”
// void main() => runApp(MyApp());
void main() {
  // 错误页面展示
  setCustomErrorPage();

  runApp(
    RootHomeBottomBar()
    );

  // 基础组件
  // runApp(BasisApp());

  // 加载图
  // runApp(LoadApp());

  // 嵌套 Tabbar 导航栏
  // runApp(MyApp());

  // iOS/Android 风格组件
  // runApp(TabbarType());
}

void setCustomErrorPage(){
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails){
      print(flutterErrorDetails.toString());
      return Center(
        child: Text("Flutter 页面出现故障"),
      );
    };
}
