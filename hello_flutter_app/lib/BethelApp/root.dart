import 'package:flutter/material.dart';

class BethelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bethel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: BethelHome(),
    );
  }
}

class BethelHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bethel'),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          // 路径裁切
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              color: Colors.blue,
              height: 200.0,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override

  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
      return false;
    }
}
