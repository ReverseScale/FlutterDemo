import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  void handleNewDate(date) {
    print("handleNewDate ${date}");
  }

  Widget todoCardList(String title, String text, Icon icon) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(left: 13), child: icon),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0, color: Colors.black38),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(48, 5, 15, 5),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'todoCard',
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 10.0,
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 15, 10),
                        child: Text(
                          'Re-design',
                          style:
                              TextStyle(fontSize: 32.0, color: Colors.black87),
                        ),
                      ),
                      Divider(
                        height: 30.0,
                      ),
                      todoCardList(
                        'Descripiton',
                        'I set the parameters & let go. in this piece, I counldn\'t let go. I had to continually engage and immerse myself.',
                        Icon(Icons.format_align_left),
                      ),
                      Divider(
                        height: 30.0,
                      ),
                      todoCardList(
                        'Projects',
                        'PRD Rebrand 2018',
                        Icon(Icons.photo_filter),
                      ),
                      Divider(
                        height: 30.0,
                      ),
                      todoCardList(
                        'Tags',
                        '+ Add Tags',
                        Icon(Icons.track_changes),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 145,
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 35),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.blue,
                              splashColor: Colors.blue,
                              child: Text('Finish',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
