import 'package:flutter/material.dart';

class FlowLayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowLayout',
      theme: ThemeData.light(),
      home: FlowLayoutHome(),
    );
  }
}

class FlowLayoutHome extends StatefulWidget {
  @override
  _FlowLayoutHomeState createState() => _FlowLayoutHomeState();
}

class _FlowLayoutHomeState extends State<FlowLayoutHome> {
  List<Widget> list;
  @override
  void initState() {
    super.initState();
    list = List<Widget>()..add(buildAddButton());
  }

  Widget buildAddButton() {
    return GestureDetector(
      onTap: () {
        if (list.length < 9) {
          setState(() {
            list.insert(list.length - 1, buildPhoto());
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80.0,
          height: 80.0,
          color: Colors.black,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildPhoto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80.0,
        height: 80.0,
        color: Colors.amberAccent,
        child: Center(
          child: Text('照片'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('FlowLayout'),
        elevation: 0.0,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Opacity(
          opacity: 0.8,
          child: Container(
            padding: const EdgeInsets.all(6),
            width: width,
            height: height,
            color: Colors.grey.shade300,
            child: Wrap(
              children: list,
              spacing: 20.0,
            ),
          ),
        ),
      )),
    );
  }
}
