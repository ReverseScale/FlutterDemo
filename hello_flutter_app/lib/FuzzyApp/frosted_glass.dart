import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.network(
                'https://avatars2.githubusercontent.com/u/13606492?s=460&v=4'),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.2, sigmaY: 5.2),
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 500.0,
                    height: 700.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Text(
                        '毛玻璃',
                        style: Theme.of(context).textTheme.display3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
