import 'package:flutter/material.dart';
import 'dart:async';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _batteryLevel = 'Unknown battery level.';

  // MethodChannel
  static const platform = const MethodChannel('samples.flutter.io/battery');

  // EventChannel
  static const EventChannel _eventChannel =
      const EventChannel('samples.flutter.io/test');

  // BasicMessageChannel
  static const messageChannel = const BasicMessageChannel(
      'samples.flutter.io/message', StandardMessageCodec());
  static const messageChannel2 = const BasicMessageChannel(
      'samples.flutter.io/message2', StandardMessageCodec());

  void _onEvent(Object event) {
    print('返回的内容: $event（Event）');
  }

  void _onError(Object error) {
    print('返回的错误（Event）');
  }

  Future<String> sendMessage() async {
    String reply = await messageChannel.send('发送给Native端的数据（Basic）');
    print('reply: $reply （Basic）');
    return reply;
  }

  void receiveMessage() {
    messageChannel2.setMessageHandler((message) async {
      print('message: $message（Basic）');
      return '返回Native端的数据（Basic）';
    });
  }

  @override
  void initState() {
    super.initState();
    // 监听开始

    print('Flutter init');
    _eventChannel.receiveBroadcastStream().listen(
          _onEvent,
          onError: _onError,
        );

    receiveMessage();
    sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_batteryLevel),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryLevel,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .（Method）';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'（Method）.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
