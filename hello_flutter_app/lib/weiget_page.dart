import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Pagetwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Widget',
          style: TextStyle(color: Colors.white),
          ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey[100],
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1.0,
          ),
          children: <Widget>[
            weigetCard(Icon(Icons.navigation), "Navigation"),
            weigetCard(Icon(Icons.tab), "Tabbar"),
            weigetCard(Icon(Icons.chat), "Chat"),
            weigetCard(Icon(Icons.search), "Search"),
            weigetCard(Icon(Icons.data_usage), "Data base"),
            weigetCard(Icon(Icons.vibration), "Animation"),
            weigetCard(Icon(Icons.filter_b_and_w), "AD"),
            weigetCard(Icon(Icons.border_style), "Bethel"),
            weigetCard(Icon(Icons.flip), "Fuzzy"),
            weigetCard(Icon(Icons.toc), "Drawer"),
            weigetCard(Icon(Icons.phonelink_setup), "Push"),
          ],
        ),
      )
    );
  }

  Widget weigetCard(Icon icon, String title) =>
    Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: icon,
            ),
            Expanded(
              child: Text(title),
            )
          ],
        ),
      ),
    );
}

