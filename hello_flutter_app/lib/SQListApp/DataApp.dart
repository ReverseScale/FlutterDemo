import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class SaveAndLoad extends StatefulWidget {
  @override
  _SaveAndLoadState createState() => _SaveAndLoadState();
}

class _SaveAndLoadState extends State<SaveAndLoad> {
  void foo() {
    const filepath = "path to your file";
    var file = File(filepath);
    try {
      bool exists = file.existsSync();
      if (!exists) {
        file.createSync();
      }
    } catch (e) {
      print(e);
    }
  }

  void saveString() {
    const filepath = "path to your file";
    var file = File(filepath);
    file.writeAsString('Hello, Dart IO');
    List<int> toBeWritten = [1, 2, 3];
    file.writeAsBytes(toBeWritten);
  }

  void fooFile() async {
    const filepath = "path to your file";
    var file = File(filepath);
    IOSink sink;
    try {
      sink = file.openWrite();
      sink.write('Hello, Dart');
      await sink.flush();
    } catch (e) {
      print(e);
    } finally {
      sink?.close();
    }
  }

  void load() {
    const filepath = "path to your file";
    var file = File(filepath);
    try {
      var msg = file.readAsString();
      print(msg);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text('Flutter Navigation')),
          body: Column(
            children: <Widget>[
              GestureDetector(
                child: Text('存储字符串'),
                onTap: () {
                  load();
                },
              )
            ],
          )),
    );
  }
}
