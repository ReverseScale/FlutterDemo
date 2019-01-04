
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter_app/CupertinoApp/common_widgets/platform_widget.dart';

class PlatformButton extends PlatformWidget<CupertinoButton, FlatButton> {
  PlatformButton({Key key, this.child, this.color, this.onPressed}) : super(key: key);
  final Widget child;
  final Color color;
  final VoidCallback onPressed;

  @override
  CupertinoButton buildCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      child: child,
      color: color,
      pressedOpacity: 0.5,
      onPressed: onPressed,
    );
  }

  @override
  FlatButton buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      color: color,
      onPressed: onPressed,
    );
  }
}
