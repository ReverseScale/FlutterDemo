import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'dart:async';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter 联调', home: Scaffold(body: HomePage(title: '联调')));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const methodChannel = const MethodChannel('com.first.your/native_get');
  static const EventChannel eventFirstChannel =
      const EventChannel('com.first.your/native_post');

  static const EventChannel eventSecondChannel =
      const EventChannel('com.second.your/native_post');

  String showText = '欢迎来到 Flutter 的世界';

  @override
  void initState() {
    super.initState();

    eventFirstChannel
        .receiveBroadcastStream('12345')
        .listen(_onFirstEvent, onError: _onError);

    eventSecondChannel
        .receiveBroadcastStream('54321')
        .listen(_onSecondEvent, onError: _onError);
  }

  void _onFirstEvent(Object event) {
    setState(() {
      showText = event.toString();
    });
  }

  void _onSecondEvent(Object event) {
    setState(() {
      showText = event.toString();
    });
  }

  void _onError(Object error) {}

  void _actionBlock() {
    setState(() {
      Map<String, String> map = {'title': '假装是参数'};
      methodChannel.invokeMethod('toNativePush', map);
    });
  }

  void _actionBack() {
    setState(() {
      methodChannel.invokeMethod('toNativePop');
    });
  }

  Future<Null> _futureAction() async {
    try {
      await methodChannel.invokeMethod('toShowAlert');
    } on PlatformException {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(showText),
          RaisedButton(
            child: Text('Push 跳转(原生)'),
            onPressed: () {
              _actionBlock();
            },
          ),
          RaisedButton(
            child: Text('返回(原生)'),
            onPressed: () {
              _actionBack();
            },
          ),
          RaisedButton(
            child: Text('提示窗(原生)'),
            onPressed: () {
              _futureAction();
            },
          ),
        ],
      ),
    );
  }
}
