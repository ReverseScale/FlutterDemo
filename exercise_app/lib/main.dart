import 'package:flutter/material.dart';
import 'package:exercise_app/section_list.dart';

void main() {
  runApp(MaterialApp(title: 'Demo', home: DemoList()));
}

class DemoList extends StatelessWidget {
  void goNext(context, page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.perm_data_setting),
              title: Text('Section List'),
              onTap: () {
                goNext(context, SectionList());
              },
            )
          ],
        ),
      ),
    );
  }
}
