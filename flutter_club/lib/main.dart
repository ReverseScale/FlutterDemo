import 'package:flutter/material.dart';

import 'package:flutter_club/root.dart';
import 'package:flutter_club/ScopedModel/Model/model_counter.dart';

void main() {
  runApp(MyApp(
    model: CounterModel(),
  ));
}
