import 'package:flutter/material.dart';
import 'package:gallery/demo/shrine/shrine_home.dart';
import 'package:gallery/demo/shrine/shrine_theme.dart';

class ShrineDemo extends StatelessWidget {
  static const String routeName = '/shrine'; // Used by the Gallery app.

  @override
  Widget build(BuildContext context) => buildShrine(context, ShrineHome());
}

Widget buildShrine(BuildContext context, Widget child) {
  return Theme(
    data: ThemeData(
      primarySwatch: Colors.grey,
      iconTheme: IconThemeData(color: Color(0xFF707070))
    ),
    child: ShrineTheme(child: child),
  );
}