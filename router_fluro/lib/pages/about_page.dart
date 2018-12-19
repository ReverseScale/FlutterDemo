import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final String message;
  final Color color;
  AboutPage({@required this.message, @required this.color});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: Container(
          color: color,
          child: Center(
            child: Text(
              "Ohh " + message + ":)",
            ),
          ),
        ));
  }
}
