import 'package:flutter/material.dart';

class ShrineHome extends StatefulWidget {
  @override
  _ShrineHomeState createState() => _ShrineHomeState();
}

class _ShrineHomeState extends State<ShrineHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shrine'),
      ),
      body: Center(
        child: Text('Shrine'),
      ),
    );
  }

}