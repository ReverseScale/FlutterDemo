import 'package:flutter/material.dart';

class BethelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bethel',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: BethelHome(),
    );
  }
}

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
      body: Column(
        children: <Widget>[
          // 路径裁切
          ClipPath(
            // clipper: ArcClipper(),
            clipper: WaterClipper(),
            child: Container(
              color: Colors.lightBlue,
              height: 200.0,
            ),
          ),
        ],
      ),
    );
  }
}

class WaterClipper extends CustomClipper<Path> {
  var volatility = 40;
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - volatility);

    var bottomControlPoint = Offset(size.width / 4, size.height);
    var bottomEndPoint = Offset(size.width / 2, size.height - volatility);
    path.quadraticBezierTo(bottomControlPoint.dx, bottomControlPoint.dy,
        bottomEndPoint.dx, bottomEndPoint.dy);

    path.lineTo(size.width / 2, size.height - volatility);

    var topControlPoint =
        Offset(size.width / 4 * 3, size.height - volatility * 2);
    var topEndPoint = Offset(size.width, size.height - volatility);
    path.quadraticBezierTo(
        topControlPoint.dx, topControlPoint.dy, topEndPoint.dx, topEndPoint.dy);

    path.lineTo(size.width, size.height - volatility);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ArcClipper extends CustomClipper<Path> {
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
