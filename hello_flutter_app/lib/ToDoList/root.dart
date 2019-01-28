
import 'package:flutter/material.dart';

import 'package:hello_flutter_app/ToDoList/todo_page.dart';

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: TodoApp(),
      routes: <String, WidgetBuilder>{
        '/page': (BuildContext context) => TodoPage()
      },
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  void _incrementCounter() {
    setState(() {});
  }

  var level1Color = Colors.red[700];
  var level2Color = Colors.purple[400];
  var level3Color = Colors.orange[600];
  var level4Color = Colors.blue[600];
  var level5Color = Colors.green[600];
  var level6Color = Colors.yellow[700];

  Widget todoCard(String title, String text, String time, Color levelColor) =>
      Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Container(
                    color: levelColor,
                    padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 20),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 14.0, color: Colors.black87),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 14.0, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var card = Expanded(
        child: Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 1,
        ),
        children: <Widget>[
          GestureDetector(
            child: Hero(
              tag: 'todoCard',
              child: todoCard('PRO', 'Painting a illustration.',
                '2018/9/17 pm 9:00', level1Color),
            ),
            onTap: () {
              // Navigator.of(context).pushNamed('/page');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return TodoPage();
              }));
            },
          ),
          todoCard('100 Day', 'Draw its user interface.', '2018/9/15 pm 11:00',
              level2Color),
          todoCard('Taobao', 'Taobao maker festival.', '2018/9/16 am 12:00',
              level3Color),
          todoCard(
              'Piano', 'Pathetique III.', '2018/9/17 am 9:00', level4Color),
          todoCard('Show', 'Dua lipa Shanghai debut.', '2018/9/17 pm 9:00',
              level5Color),
          todoCard('Ideas', 'Instrument recording, mixing.',
              '2018/9/15 am 11:30', level6Color),
        ],
      ),
    ));

    return Scaffold(
      body: Container(
        color: Colors.grey[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 80, 10, 0),
              child: Text(
                'Hey Steven',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: Text(
                'This is your to-do list.',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
            card,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: Colors.blue,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
