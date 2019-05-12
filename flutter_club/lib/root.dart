import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_club/ScopedModel/Model/model_counter.dart';
import 'package:flutter_club/ScopedModel/Page/page_counter_scoped_model.dart';

class MyApp extends StatelessWidget {
  final CounterModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        title: 'Flutter Club',
        home: CounterHome('Counter'),
      ),
    );
  }
}
