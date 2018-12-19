import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:router_fluro/helpers/color_helpers.dart';

import 'package:router_fluro/pages/home_page.dart';
import 'package:router_fluro/pages/about_page.dart';
import 'package:router_fluro/pages/me_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var aboutPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["name"]?.first;
  String colorHex = params["color_hex"]?.first;
  Color color = Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
    print(colorHex);
    color = Color(ColorHelpers.fromHexString(colorHex));
  }
  print(message);
  return AboutPage(
    message: message,
    color: color,
  );
});

var mePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["message"]?.first;
  print(message);
  return MePage(message: message);
});


var demoFunctionHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String message = params["message"]?.first;
      showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(
              "Hey Hey!",
              style: new TextStyle(
                color: const Color(0xFF00D6F7),
                fontFamily: "Lazer84",
                fontSize: 22.0,
              ),
            ),
            content: new Text("$message"),
            actions: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
                child: new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: new Text("OK"),
                ),
              ),
            ],
          );
        },
      );
    });