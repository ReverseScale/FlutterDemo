import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:router_fluro/pages/root_page.dart';
import 'package:router_fluro/pages/home_page.dart';
import 'package:router_fluro/pages/about_page.dart';

void main() {
  Router router = Router();

  router.define('root', handler:
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return RootPage();
  }));

  router.define('home', handler:
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomePage();
  }));

  router.define('about', handler:
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return AboutPage();
  }));

  runApp(MaterialApp(
      title: 'Ruter', home: RootPage(), onGenerateRoute: router.generator));
}
