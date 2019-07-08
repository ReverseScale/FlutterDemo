import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platformBaicMessage =
      const BasicMessageChannel('BasicMessageChannel', StandardMessageCodec());

  static const platformBattery =
      const MethodChannel('samples.flutter.io/battery');
  static const platformMessage =
      const MethodChannel('samples.flutter.io/message');

  static const platformChannel =
      const MethodChannel('samples.flutter.io/toast');
  static const eventChannel = const EventChannel('samples.flutter.io/event');

  String textContent = 'Flutter Message';
  String textContent2 = 'Flutter Message too';

  String _batteryLevel = 'Unknown battery level.';
  String _messageChannel = 'Unknown channel message.';

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onListen,
        onError: _onError, onDone: _onDone, cancelOnError: false);
  }

  void _onListen(dynamic data) {
    setState(() {
      textContent2 = data;
    });
  }

  void _onError(Object o) {
    setState(() {
      textContent2 = 'EventChannel error';
    });
  }

  void _onDone() {
    setState(() {
      textContent2 = 'EventChannel done';
    });
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platformBattery.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<Null> _getMessageChannel() async {
    String messageChannel;
    try {
      // final String result = await platformMessage.invokeMethod('getMessage');
      final String result = await platformBattery.invokeMethod('getMessage');
      messageChannel = 'Message is $result.';
    } on PlatformException catch (e) {
      messageChannel = "Failed to get message: '${e.message}'.";
    }

    setState(() {
      _messageChannel = messageChannel;
    });
  }

  void showToast(String content) async {
    var arguments = Map();
    arguments['content'] = content;

    try {
      String result = await platformChannel.invokeMethod('toast', arguments);
      print('showToast ' + result);
    } on PlatformException catch (e) {
      print('showToast ' + e.code + e.message + e.details);
    } on MissingPluginException catch (e) {
      print('showToast ' + e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_batteryLevel',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                '$_messageChannel',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _getBatteryLevel,
              child: Icon(Icons.battery_full),
            ),
            FloatingActionButton(
              onPressed: _getMessageChannel,
              child: Icon(Icons.message),
            ),
            FloatingActionButton(
              onPressed: () {
                showToast('Flutter Toast');
              },
              child: Icon(Icons.warning),
            ),
          ],
        ));
  }
}
