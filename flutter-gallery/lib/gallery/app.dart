import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gallery/gallery/demos.dart';
import 'package:gallery/gallery/home.dart';
import 'package:gallery/gallery/option.dart';
import 'package:gallery/gallery/theme.dart' as theme;
import 'package:gallery/gallery/scale.dart' as scale;
import 'package:gallery/gallery/updater.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryApp extends StatefulWidget {
  const GalleryApp({
    Key key,
    this.updateUrlFetcher,
    this.enablePerformanceOverlay = true,
    this.enableRasterCacheImagesCheckerboard = true,
    this.enableOffscreenLayersCheckerboard = true,
    this.onSendFeedback,
    this.testMode = false,
  }) : super(key: key);

  final UpdateUrlFetcher updateUrlFetcher;
  final bool enablePerformanceOverlay;
  final bool enableRasterCacheImagesCheckerboard;
  final bool enableOffscreenLayersCheckerboard;
  final VoidCallback onSendFeedback;
  final bool testMode;

  @override
  State<StatefulWidget> createState() => _GalleryAppState();

}

class _GalleryAppState extends State<GalleryApp> {
  GalleryOption _option;
  Timer _timeDilationTimer;

  _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      allGalleryDemos,
      key: (demo) => demo.routeName,
      value: (demo) => demo.buildRoute
    );
  }

  @override
  void initState() {
    super.initState();
    _option = GalleryOption(
      theme: theme.lightGalleryTheme,
      textScaleFactor: scale.allGalleryTextScaleValues[0],
      timeDilation: timeDilation,
      platform: defaultTargetPlatform,
    );
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  void _handleOptionChanged(GalleryOption newOption) {
    setState(() {
      if (_option.timeDilation != newOption.timeDilation) {
        _timeDilationTimer?.cancel();
        _timeDilationTimer = null;
        if (newOption.timeDilation > 1.0) {
          // We delay the time dilation change long enough that the user can see
          // that UI has started reacting and then we slam on the brakes so that
          // they see that the time is in fact now dilated.
          _timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
            timeDilation = newOption.timeDilation;
          });
        } else {
          timeDilation = newOption.timeDilation;
        }
      }

      _option = newOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget home = GalleryHome(
      testMode: widget.testMode,
      optionsPage: GalleryOptionPage(
        option: _option,
        onOptionChanged: _handleOptionChanged,
        onSendFeedback: widget.onSendFeedback ?? () {
          launch('https://github.com/flutter/flutter/issues/new/choose', forceSafariVC: false);
        },
      ),
    );

    if (widget.updateUrlFetcher != null) {
      home = Updater(
        updateUrlFetcher: widget.updateUrlFetcher,
        child: home,
      );
    }

    return MaterialApp(
      theme: _option.theme.data.copyWith(platform: _option.platform),
      title: 'Flutter Gallery',
      color: Colors.grey,
      showPerformanceOverlay: _option.showPerformanceOverlay,
      checkerboardOffscreenLayers: _option.showOffscreenLayersCheckerboard,
      checkerboardRasterCacheImages: _option.showRasterCacheImagesCheckerboard,
      routes: _buildRoutes(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: _option.textDirection,
          child: _applyTextScaleFactor(child),
        );
      },
      home: home,
    );
  }

  Widget _applyTextScaleFactor(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: _option.textScaleFactor.scale,
          ),
          child: child,
        );
      },
    );
  }
}