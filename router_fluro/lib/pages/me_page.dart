import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  final String message;
  MePage({@required this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(child: Text(
        "Ohh " + message + ":)",
      )),
    );
  }
}