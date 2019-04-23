import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gallery/gallery/about.dart';
import 'scale.dart';
import 'theme.dart';

class GalleryOption {
  GalleryOption({
    this.theme,
    this.textScaleFactor,
    this.textDirection = TextDirection.ltr,
    this.timeDilation = 1.0,
    this.platform,
    this.showOffscreenLayersCheckerboard = false,
    this.showRasterCacheImagesCheckerboard = false,
    this.showPerformanceOverlay = false,
  });

  final GalleryTheme theme;
  final GalleryTextScaleValue textScaleFactor;
  final TextDirection textDirection;
  final double timeDilation;
  final TargetPlatform platform;
  final bool showPerformanceOverlay;
  final bool showRasterCacheImagesCheckerboard;
  final bool showOffscreenLayersCheckerboard;

  GalleryOption copyWith({
    GalleryTheme theme,
    GalleryTextScaleValue textScaleFactor,
    TextDirection textDirection,
    double timeDilation,
    TargetPlatform platform,
    bool showPerformanceOverlay,
    bool showRasterCacheImagesCheckerboard,
    bool showOffscreenLayersCheckerboard,
  }) {
    return GalleryOption(
      theme: theme ?? this.theme,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textDirection: textDirection ?? this.textDirection,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
      showOffscreenLayersCheckerboard: showOffscreenLayersCheckerboard ?? this.showOffscreenLayersCheckerboard,
      showRasterCacheImagesCheckerboard: showRasterCacheImagesCheckerboard ?? this.showRasterCacheImagesCheckerboard,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType)
      return false;
    final GalleryOption typedOther = other;
    return theme == typedOther.theme
        && textScaleFactor == typedOther.textScaleFactor
        && textDirection == typedOther.textDirection
        && platform == typedOther.platform
        && showPerformanceOverlay == typedOther.showPerformanceOverlay
        && showRasterCacheImagesCheckerboard == typedOther.showRasterCacheImagesCheckerboard
        && showOffscreenLayersCheckerboard == typedOther.showRasterCacheImagesCheckerboard;
  }

  @override
  int get hashCode => hashValues(
    theme,
    textScaleFactor,
    textDirection,
    timeDilation,
    platform,
    showPerformanceOverlay,
    showRasterCacheImagesCheckerboard,
    showOffscreenLayersCheckerboard,
  );

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}

const double _itemHeight = 48.0;
const EdgeInsetsDirectional itemPadding = EdgeInsetsDirectional.only(start: 56.0);

class _OptionItem extends StatelessWidget {
  final Widget child;
  const _OptionItem({ Key key, this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double textScale = MediaQuery.textScaleFactorOf(context);
    return MergeSemantics(
      child: Container(
        constraints: BoxConstraints(minHeight: _itemHeight * textScale),
        padding: itemPadding,
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
            style: DefaultTextStyle.of(context).style,
            maxLines: 2,
            overflow: TextOverflow.fade,
            child: IconTheme(data: Theme.of(context).primaryIconTheme, child: child)
        ),
      ),
    );
  }
}

class _BoolItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  // [switchKey] is used for accessing the switch from driver tests.
  final Key switchKey;

  const _BoolItem(this.title, this.value, this.onChanged, { this.switchKey });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return _OptionItem(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title)),
          Switch(
            key: switchKey,
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF39CEFD),
            activeTrackColor: isDark ? Colors.white30 : Colors.black26,
          )
        ],
      ),
    );
  }
}

class _FlatButton extends StatelessWidget {
  const _FlatButton({ Key key, this.onPressed, this.child }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: DefaultTextStyle(style: Theme.of(context).primaryTextTheme.subhead, child: child)
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem(this.text, this.onTap);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _OptionItem(
      child: _FlatButton(
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _OptionItem(
      child: DefaultTextStyle(
        style: theme.textTheme.body1.copyWith(fontFamily: 'GoogleSans', color: theme.accentColor),
        child: Semantics(
          child: Text(text),
          header: true,
        )
      ),
    );
  }
}

class _ThemeItem extends StatelessWidget {
  final GalleryOption option;
  final ValueChanged<GalleryOption> onOptionChanged;

  const _ThemeItem(this.option, this.onOptionChanged);

  @override
  Widget build(BuildContext context) {
    return _BoolItem(
      'Dark Theme',
      option.theme == darkGalleryTheme,
      (bool value) {
        onOptionChanged(option.copyWith(theme: value ? darkGalleryTheme : lightGalleryTheme));
      },
      switchKey: const Key('dark_theme'),
    );
  }
}

class _TextScaleItem extends StatelessWidget {
  final GalleryOption option;
  final ValueChanged<GalleryOption> onOptionChanged;

  const _TextScaleItem(this.option, this.onOptionChanged);

  @override
  Widget build(BuildContext context) {
    return _OptionItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Text size'),
                Text('${option.textScaleFactor.label}',
                  style: Theme.of(context).primaryTextTheme.body1,
                ),
              ],
            ),
          ),
          PopupMenuButton<GalleryTextScaleValue>(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            icon: const Icon(Icons.arrow_drop_down),
            itemBuilder: (context) {
              return allGalleryTextScaleValues.map((value) {
                return PopupMenuItem(
                  value: value,
                  child: Text(value.label),
                );
              }).toList();
            },
            onSelected: (GalleryTextScaleValue value) {
              onOptionChanged(option.copyWith(textScaleFactor: value));
            },
          )
        ],
      ),
    );
  }
}

class _TextDirectionItem extends StatelessWidget {
  final GalleryOption option;
  final ValueChanged<GalleryOption> onOptionChanged;

  const _TextDirectionItem(this.option, this.onOptionChanged);

  @override
  Widget build(BuildContext context) {
    return _BoolItem(
      'Force RTL',
      option.textDirection == TextDirection.rtl,
      (bool value) => onOptionChanged(option.copyWith(textDirection: value ? TextDirection.rtl : TextDirection.ltr)),
      switchKey: const Key('text_direction'),
    );
  }
}

class _TimeDilationItem extends StatelessWidget {
  final GalleryOption option;
  final ValueChanged<GalleryOption> onOptionChanged;

  const _TimeDilationItem(this.option, this.onOptionChanged);

  @override
  Widget build(BuildContext context) {
    return _BoolItem(
      'Slow motion',
      option.timeDilation != 1.0,
      (bool value) => onOptionChanged(option.copyWith(timeDilation: value ? 20.0 : 1.0)),
      switchKey: const Key('slow_motion'),
    );
  }
}

class _PlatformItem extends StatelessWidget {
  final GalleryOption option;
  final ValueChanged<GalleryOption> onOptionChanged;

  const _PlatformItem(this.option, this.onOptionChanged);

  String _platformLabel(TargetPlatform platform) {
    switch(platform) {
      case TargetPlatform.android:
        return 'Mountain View';
      case TargetPlatform.fuchsia:
        return 'Fuchsia';
      case TargetPlatform.iOS:
        return 'Cupertino';
    }
    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _OptionItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Platform mechanics'),
                Text('${_platformLabel(option.platform)}',
                  style: Theme.of(context).primaryTextTheme.body1,
                ),
              ],
            ),
          ),
          PopupMenuButton<TargetPlatform>(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            icon: const Icon(Icons.arrow_drop_down),
            itemBuilder: (context) {
              return TargetPlatform.values.map((platform) {
                return PopupMenuItem(
                  value: platform,
                  child: Text(_platformLabel(platform)),
                );
              }).toList();
            },
            onSelected: (platform) {
              onOptionChanged(option.copyWith(platform: platform));
            },
          )
        ],
      ),
    );
  }
}

class GalleryOptionPage extends StatelessWidget {
  const GalleryOptionPage({
    Key key,
    this.option,
    this.onOptionChanged,
    this.onSendFeedback,
  }) : super(key: key);

  final GalleryOption option;
  final ValueChanged<GalleryOption> onOptionChanged;
  final VoidCallback onSendFeedback;

  List<Widget> _getDiagnosticItems() {
    if (null == option.showOffscreenLayersCheckerboard
      ?? option.showRasterCacheImagesCheckerboard
      ?? option.showPerformanceOverlay
    )
      return const <Widget>[];

    final List<Widget> items = [
      const Divider(),
      const _Heading('Diagnostics'),
    ];

    if (option.showOffscreenLayersCheckerboard != null) {
      items.add(_BoolItem(
          'Highlight offscreen layers',
          option.showOffscreenLayersCheckerboard,
          (value) {
            onOptionChanged(option.copyWith(showOffscreenLayersCheckerboard: value));
          }));
    }

    if (option.showRasterCacheImagesCheckerboard != null) {
      items.add(_BoolItem(
          'Highlight raster cache images',
          option.showRasterCacheImagesCheckerboard,
              (value) {
            onOptionChanged(option.copyWith(showRasterCacheImagesCheckerboard: value));
          }));
    }

    if (option.showPerformanceOverlay != null) {
      items.add(_BoolItem(
          'Show performance overlay',
          option.showPerformanceOverlay,
              (value) {
            onOptionChanged(option.copyWith(showPerformanceOverlay: value));
          }));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.primaryTextTheme.subhead,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 124.0),
        children: <Widget>[
          _Heading('Display'),
          _ThemeItem(option, onOptionChanged),
          _TextScaleItem(option, onOptionChanged),
          _TextDirectionItem(option, onOptionChanged),
          _TimeDilationItem(option, onOptionChanged),
          const Divider(),
          const _Heading('Platform mechanics'),
          _PlatformItem(option, onOptionChanged),
        ]..addAll(_getDiagnosticItems())
        ..addAll([
          const Divider(),
          const _Heading('Flutter gallery'),
          _ActionItem('About Flutter Gallery', () => showGalleryAboutDialog(context)),
          _ActionItem('Send feedback', () => onSendFeedback()),
        ]),
      )
    );
  }
}