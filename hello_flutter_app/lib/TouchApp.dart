import 'package:flutter/material.dart';

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
                )
              ],
            )));
  }
}

