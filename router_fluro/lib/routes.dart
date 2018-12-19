import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:router_fluro/route_handlers.dart';

class Routes {
  static String root = "/";
  static String aboutSimple = "/pages/about";
  static String meSimple = "/pages/me";
  static String demoFunc = "/demo/func";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(aboutSimple, handler: aboutPageHandler);
    router.define(meSimple, handler: mePageHandler);
    router.define(demoFunc, handler: demoFunctionHandler);
  }
}
