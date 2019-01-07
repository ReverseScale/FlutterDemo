import 'package:flutter/material.dart';

class CustomRouter extends PageRouteBuilder {
  final Widget widget;
  CustomRouter(this.widget)
      : super(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
            ) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child
                ) {
                  // 渐变 路由动画
                  return FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
                  child: child,
                  );

                  // 缩放 路由动画
                });
}
