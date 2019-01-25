import 'package:flutter/material.dart';

class ColorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Colors',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: LinearGradientContainer()
    );
  }
}

// 渐变容器
class LinearGradientContainer extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Container(
      child: Text(
        'Hello Flutter \n🤪🤪🤪🤪🤪🤪',
        style: TextStyle(fontSize: 38.0),
      ),
      alignment: Alignment.topCenter,
      width: 500.0,
      height: 400.0,
      // color: Colors.lightBlue,
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Colors.greenAccent,
            Colors.lightBlue,
            Colors.purpleAccent
          ]),
          border: Border.all(width: 2.0, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(15.0)),
    );
  }
}