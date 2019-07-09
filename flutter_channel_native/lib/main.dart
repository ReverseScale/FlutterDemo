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
  // MethodChannel 方法示例部分
  static const platformBattery =
      const MethodChannel('samples.flutter.io/battery');
  
  String _batteryLevel = 'Unknown battery level.';
  String _messageChannel = 'Unknown channel message.';

  // EventChannel 方法示例部分
  static const eventChannel = const EventChannel('samples.flutter.io/event');
  static const platformChannel =
      const MethodChannel('samples.flutter.io/toast');

  String _textContent = 'Flutter Message';

  // BasicMessageChannel 方法示例部分
  static const messageChannel1 = const BasicMessageChannel(
      'samples.flutter.io/message1', StandardMessageCodec());
  static const messageChannel2 = const BasicMessageChannel(
      'samples.flutter.io/message2', StandardMessageCodec());

  @override
  void initState() {
    super.initState();

    eventChannel.receiveBroadcastStream().listen(
          _onListen,
          onError: _onError,
          onDone: _onDone,
          cancelOnError: false,
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
              Text(
                '$_textContent',
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
                _showToast('Flutter Toast');
              },
              child: Icon(Icons.warning),
            ),
          ],
        ));
  }

  Future<String> sendMessage() async {
    String reply = await messageChannel1.send('发送给Native端的数据');
    print('reply: $reply');
    return reply;
  }

  void receiveMessage() {
    messageChannel2.setMessageHandler((message) async {
      print('message: $message');
      return '返回 Native 端的数据';
    });
  }

  void _onListen(dynamic data) {
    setState(() {
      _textContent = data;
    });
  }

  void _onError(Object error) {
    setState(() {
      _textContent = 'EventChannelInfo error';
    });
  }

  void _onDone() {
    setState(() {
      _textContent = 'EventChannelInfo done';
    });
  }

  // 获取电池电量
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

  // 获取原生消息
  Future<Null> _getMessageChannel() async {
    String messageChannel;
    try {
      final String result = await platformBattery.invokeMethod('getMessage');
      messageChannel = 'Message is $result.';
    } on PlatformException catch (e) {
      messageChannel = "Failed to get message: '${e.message}'.";
    }

    setState(() {
      _messageChannel = messageChannel;
    });
  }

  void _showToast(String content) async {
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
}
