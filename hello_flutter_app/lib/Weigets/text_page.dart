import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Text(
          'Hello Word! \n\n\n🤪\n\n我是一个专门展示文本的东西\n额，我当然也是一个组件。',
          textAlign: TextAlign.center,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 24.0,
            color: Color.fromRGBO(47, 79, 79, 1),
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
      ),
    );
  }
}
