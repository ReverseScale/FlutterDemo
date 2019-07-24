import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Animation',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: AnimationPage(),
    );
  }
}

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
      case 1:
        widget = MovementAniWidget();
        break;
      case 2:
        widget = RadiusAniWidget();
        break;
      case 3:
        widget = ColorAniWidget();
        break;
      case 4:
        widget = RotateAniWidget();
        break;
      case 5:
        widget = DeformAniWidget();
        break;
      case 6:
        widget = StaggeredAniWidget();
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: _buildAnimation(),
          ),
          ListTile(
            title: Text('透明度动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 0;
              });
            },
          ),
          ListTile(
            title: Text('位移动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 1;
              });
            },
          ),
          ListTile(
            title: Text('圆角动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 2;
              });
            },
          ),
          ListTile(
            title: Text('颜色动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 3;
              });
            },
          ),
          ListTile(
            title: Text('旋转动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 4;
              });
            },
          ),
          ListTile(
            title: Text('形变动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 5;
              });
            },
          ),
          Divider(),
          ListTile(
            title: Text('混合动画效果'),
            onTap: () {
              setState(() {
                _aniIndex = 6;
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
  Animation<double> _animationOpacity;
  AnimationController _controller;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    _animationOpacity = Tween<double>(
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

  _startAnimation() async {
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
      opacity: _animationOpacity.value,
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

// 位移
class MovementAniWidget extends StatefulWidget {
  @override
  _MovementAniWidgetState createState() => _MovementAniWidgetState();
}

class _MovementAniWidgetState extends State<MovementAniWidget>
    with TickerProviderStateMixin {
  Animation<EdgeInsets> _animationMovement;
  AnimationController _controller;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    _animationMovement = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 0.0, right: 0.0),
      end: EdgeInsets.only(top: 150.0, right: 150.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.decelerate,
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

  _startAnimation() async {
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
    return Container(
      color: Colors.blue,
      height: 200.0,
      width: 400.0,
      padding: _animationMovement.value,
      child: Center(
        child: Text(
          '位移',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

// 圆角
class RadiusAniWidget extends StatefulWidget {
  @override
  _RadiusAniWidgetState createState() => _RadiusAniWidgetState();
}

class _RadiusAniWidgetState extends State<RadiusAniWidget>
    with TickerProviderStateMixin {
  Animation<BorderRadius> _animationRadius;
  AnimationController _controller;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    _animationRadius = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(100.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          0.8,
          curve: Curves.ease,
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

  _startAnimation() async {
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
    return Container(
      height: 200.0,
      width: 200.0,
      child: Center(
        child: Text(
          '圆角',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.purple,
        border: Border.all(
          color: Colors.purple,
          width: 2.0,
        ),
        borderRadius: _animationRadius.value,
      ),
    );
  }
}

// 颜色
class ColorAniWidget extends StatefulWidget {
  @override
  _ColorAniWidgetState createState() => _ColorAniWidgetState();
}

class _ColorAniWidgetState extends State<ColorAniWidget>
    with TickerProviderStateMixin {
  Animation<Color> _animationColor;
  AnimationController _controller;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    _animationColor = ColorTween(
      begin: Colors.red[500],
      end: Colors.blue[900],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.linear,
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

  _startAnimation() async {
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
    return Container(
      color: _animationColor.value,
      height: 200.0,
      width: 400.0,
      child: Center(
        child: Text(
          '颜色',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

// 旋转
class RotateAniWidget extends StatefulWidget {
  @override
  _RotateAniWidgetState createState() => _RotateAniWidgetState();
}

class _RotateAniWidgetState extends State<RotateAniWidget>
    with TickerProviderStateMixin {
  Animation<double> _animationRotate;
  AnimationController _controller;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    _animationRotate = Tween<double>(
      begin: 0.0,
      end: math.pi * 0.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          0.3,
          curve: Curves.ease,
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

  _startAnimation() async {
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
    return Container(
      color: Colors.green,
      height: 200.0,
      width: 400.0,
      transform: Matrix4.identity()..rotateZ(_animationRotate.value),
      child: Center(
        child: Text(
          '旋转',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

// 形变
class DeformAniWidget extends StatefulWidget {
  @override
  _DeformAniWidgetState createState() => _DeformAniWidgetState();
}

class _DeformAniWidgetState extends State<DeformAniWidget>
    with TickerProviderStateMixin {
  Animation<double> _animationWidth;
  Animation<double> _animationHeight;
  AnimationController _controller;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    _animationHeight = Tween<double>(
      begin: 100.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.3,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
      });

    _animationWidth = Tween<double>(
      begin: 100.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
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

  _startAnimation() async {
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
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _animationWidth.value,
      height: _animationHeight.value,
      color: Colors.deepPurple,
      child: Center(
        child: Text(
          '形变',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

// 混合
class StaggeredAniWidget extends StatefulWidget {
  @override
  _StaggeredAniWidgetState createState() => _StaggeredAniWidgetState();
}

class _StaggeredAniWidgetState extends State<StaggeredAniWidget>
    with TickerProviderStateMixin {
  Animation<double> _animationOpacity;

  Animation<EdgeInsets> _animationMovement;
  Animation<Color> _animationColor;
  Animation<BorderRadius> _animationRadius;
  Animation<double> _animationRotate;
  Animation<double> _animationWidth;
  Animation<double> _animationHeight;
  AnimationController _controller;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    _animationOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.1,
          curve: Curves.easeIn,
        ),
      ),
    );

    _animationRotate = Tween<double>(
      begin: 0.0,
      end: math.pi * 2.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.ease,
        ),
      ),
    );

    _animationMovement = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 0.0),
      end: EdgeInsets.only(top: 100.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          0.375,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _animationColor = ColorTween(
      begin: Colors.blue[300],
      end: Colors.blue[900],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          0.75,
          curve: Curves.linear,
        ),
      ),
    );

    _animationRadius = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(100.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );

    _animationHeight = Tween<double>(
      begin: 100.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.375,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _animationWidth = Tween<double>(
      begin: 100.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.375,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  _startAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
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
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildAni(BuildContext context, Widget child) {
    return Container(
      padding: _animationMovement.value,
      transform: Matrix4.identity()..rotateZ(_animationRotate.value),
      child: Opacity(
        opacity: _animationOpacity.value,
        child: Container(
          width: _animationWidth.value,
          height: _animationHeight.value,
          decoration: BoxDecoration(
            color: _animationColor.value,
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
            borderRadius: _animationRadius.value,
          ),
          child: Center(
            child: Text(
              '混合',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
          child: FlatButton(
              textColor: Colors.black,
              child: Text('混合效果'),
              onPressed: () {
                _startAnimation();
              }),
        ),
        AnimatedBuilder(animation: _controller, builder: _buildAni)
      ],
    );
  }
}
