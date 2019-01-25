import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: NetworkImage()
    );
  }
}

class NetworkImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      'http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-11-16/77393802.jpg',
      fit: BoxFit.contain,
      color: Colors.greenAccent,
      colorBlendMode: BlendMode.multiply,
      repeat: ImageRepeat.repeat,
    );
  }
}