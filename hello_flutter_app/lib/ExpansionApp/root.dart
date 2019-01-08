import 'package:flutter/material.dart';

class ExpansionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Closed',
      theme: ThemeData.dark(),
      home: ExpansionHome(),
    );
  }
}

class ExpansionHome extends StatefulWidget {
  @override
  _ExpansionHomeState createState() => _ExpansionHomeState();
}

class _ExpansionHomeState extends State<ExpansionHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Closed'),
        elevation: 0.0,
      ),
      body: Center(
        child: ExpansionTile(
          title: Text('点我展开'),
          leading: Icon(Icons.ac_unit),
          backgroundColor: Colors.white12,
          initiallyExpanded: false,
          children: <Widget>[
            ListTile(
              title: Text('你看到我啦'),
              subtitle: Text('我是副标题 🌶 🌶 🌶'),
            )
          ],
        ),
      ),
    );
  }
}
