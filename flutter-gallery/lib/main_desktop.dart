import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery/demo/pesto_demo.dart';
import 'package:gallery/gallery/app.dart';

void main() {
//  debugPaintSizeEnabled = true;
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  return runApp(const GalleryApp());
}
