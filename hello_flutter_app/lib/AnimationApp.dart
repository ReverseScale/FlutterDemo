import 'package:flutter/material.dart';

// 动画
class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  int _aniIndex = 0;
  Widget _buildAnimation() {
    Widget widget;
    switch (_aniIndex) {
      case 0:
        widget = OpacityAniWidget();
        break;
      // case 1:
      //   widget = new MovementAniWidget();
      //   break;
      // case 2:
      //   widget = new RadiusAniWidget();
      //   break;
      // case 3:
      //   widget = new ColorAniWidget();
      //   break;
      // case 4:
      //   widget = new RotateAniWidget();
      //   break;
      // case 5:
      //   widget = new DeformAniWidget();
      //   break;
      // case 6:
      //   widget = new StaggeredAniWidget();
      //   break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('动画')),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: _buildAnimation(),
          ),
          ListTile(
            title: new Text('透明度动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 0;
              });
            },
          ),
        ],
      ),
    );
  }
}

// 透明度
class OpacityAniWidget extends StatefulWidget {
  @override
  _OpacityAniWidgetState createState() => _OpacityAniWidgetState();
}

class _OpacityAniWidgetState extends State<OpacityAniWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> opacity;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
      });
  }

  Future _startAnimation() async {
    try {
      await _controller.repeat();
    } on TickerCanceled {
      print('Animation Failed');
    }
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _initAni();
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.value,
      child: Center(
        child: Container(
          color: Colors.red,
          height: 200,
          width: 400,
          child: Center(
            child: Text(
              '透明度',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
