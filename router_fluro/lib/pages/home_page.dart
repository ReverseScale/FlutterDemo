import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:router_fluro/application.dart';

String textField_text;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(46.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Ohh, Who are you?",
                    hintStyle:
                        TextStyle(color: Colors.black26, fontSize: 24.0)),
                autocorrect: true,
                style: TextStyle(color: Colors.black45, fontSize: 24.0),
                maxLines: 1,
                keyboardType: TextInputType.text,
                onSubmitted: (String s) {
                  textField_text = s;
                },
                onChanged: (String s) {
                  textField_text = s;
                },
              ),
            ),
            RaisedButton(
              onPressed: () {
                String name = textField_text;
                print(name);
                Application.router.navigateTo(
                    context, '/pages/about?name=$name&color_hex=#f4424b',
                    transition: TransitionType.fadeIn);
              },
              color: Colors.blue[100],
              child: Text(
                "Call me !",
              ),
            ),
            RaisedButton(
              onPressed: () {
                String message = "You tapped the function button!";
                Application.router
                    .navigateTo(context, "/demo/func?message=$message");
              },
              color: Colors.blue[100],
              child: Text(
                "Touch me !",
              ),
            ),
            FlatButton(
              onPressed: () {
                String mess = 'That\'s interesting, right? I\'m router.';
                Application.router.navigateTo(
                    context, '/pages/me?message=$mess',
                    transition: TransitionType.fadeIn);
              },
              child: Text('About'),
            ),
          ],
        ));
  }
}
