import 'package:flutter/material.dart';
import 'frosted_glass.dart';

class FuzzyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuzzy',
      theme: ThemeData.light(),
      home: Scaffold(
        body: FrostedPage(),
      ),
    );
  }
}