import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class TouchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TouchState(),
    );
  }
}

class GesturesBackHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('GesturesBack'),
      ),
      child: Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          color: CupertinoColors.activeBlue,
          child: CupertinoButton(
            child: Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return NextPage();
              }));
            },
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text('Next Page'),
          leading: GestureDetector(
            child: Icon(CupertinoIcons.back),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      child: Center(child: Text('Welcome')),
    );
  }
}

class TouchState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(title: Text('Flutter Navigation')),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Divider(),
                GestureDetector(
                  child: Text('GestureDetector'),
                  onTap: () {
                    debugPrint('clicked');
                  },
                  onDoubleTap: () {
                    debugPrint('clicked double');
                  },
                  onLongPress: () {
                    debugPrint('clicked long');
                  },
                ),
                Divider(),
                Listener(
                  child: Text('Listener'),
                  onPointerMove: (event) {
                    debugPrint('onPointerMove');
                  },
                  onPointerCancel: (event) {
                    debugPrint('onPointerCancel');
                  },
                  onPointerDown: (event) {
                    debugPrint('onPointerDown');
                  },
                  onPointerUp: (event) {
                    debugPrint('onPointerUp');
                  },
                ),
                Divider(),
                AnimWidget(),
                AnimCurve(),
                AnimationDemoView(),
              ],
            )));
  }
}

class AnimWidget extends StatefulWidget {
  @override
  _AnimWidgetState createState() => _AnimWidgetState();
}

class _AnimWidgetState extends State<AnimWidget>
    with SingleTickerProviderStateMixin {
  var controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: FlutterLogo(
        size: 50,
      ),
      scale: controller,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimCurve extends StatefulWidget {
  @override
  _AnimCurveState createState() => _AnimCurveState();
}

class _AnimCurveState extends State<AnimCurve>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var scaled = ScaleTransition(
      child: FlutterLogo(size: 50.0),
      scale: curve,
    );
    return FadeTransition(
      child: scaled,
      opacity: curve,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimationDemoView extends StatefulWidget {
  @override
  State createState() {
    return _AnimationState();
  }
}

class _AnimationState extends State<AnimationDemoView>
    with SingleTickerProviderStateMixin {
  static const padding = 16.0;
  Animation<Color> color;

  AnimationController controller;
  Animation<double> left;
  @override
  void initState() {
    super.initState();
    Future(_initState);
  }

  void _initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    final mediaQueryData = MediaQuery.of(context);
    final displayWidth = mediaQueryData.size.width;
    debugPrint('width = $displayWidth');

    left =
        Tween(begin: padding, end: displayWidth - padding).animate(controller)
          ..addListener(() {
            setState(() {
              // have nothing to do
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // 我们让动画反正执行一遍
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              // 正着重新开始
              controller.forward();
            }
          });
    controller.forward();

    color = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final color = this.color == null ? Colors.red : this.color.value;

    // 假定一个单位是 24
    final unit = 24.0;
    final marginLeft = left == null ? padding : left.value;

    final unitizedLeft = (marginLeft - padding) / unit;
    final unitizedTop = math.sin(unitizedLeft);
    final marginTop = (unitizedTop + 1) * unit + padding;
    return Container(
      margin: EdgeInsets.only(left: marginLeft, top: marginTop),
      // 画一个小红点
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(7.5)),
        width: 15.0,
        height: 15.0,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
