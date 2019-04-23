import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text}) : super(
    style: style,
    text: text ?? url,
    recognizer: TapGestureRecognizer()..onTap = () => launch(url, forceSafariVC: false)
  );
}

showGalleryAboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.body2;
  final TextStyle linkStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);

  showAboutDialog(
    context: context,
    applicationVersion: 'April 2018 Preview',
    applicationIcon: const FlutterLogo(),
    applicationLegalese: '© 2017 The Chromium Authors',
    children: [
      Padding(
        padding: EdgeInsets.only(top: 24.0),
        child: RichText(text: TextSpan(
          children: [
            TextSpan(
              style: aboutTextStyle,
              text: 'Flutter is an early-stage, open-source project to help developers '
                  'build high-performance, high-fidelity, mobile apps for '
                  '${defaultTargetPlatform == TargetPlatform.iOS ? 'multiple platforms' : 'iOS and Android'} '
                  'from a single codebase. This gallery is a preview of '
                  "Flutter's many widgets, behaviors, animations, layouts, "
                  'and more. Learn more about Flutter at '
            ),
            _LinkTextSpan(
              style: linkStyle,
              url: 'https://flutter.io'
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '.\n\nTo see the source code for this app, please visit the ',
            ),
            _LinkTextSpan(
              style: linkStyle,
              url: 'https://goo.gl/iv1p4G',
              text: 'flutter github repo',
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '.',
            ),
          ]
        )),
      )
    ]
  );
}

showAboutDialog({
  @required BuildContext context,
  String applicationName,
  String applicationVersion,
  Widget applicationIcon,
  String applicationLegalese,
  List<Widget> children,
}) {
  showDialog(context: context,
    builder: (context) {
      return AboutDialog(
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationIcon: applicationIcon,
        applicationLegalese: applicationLegalese,
        children: children,
      );
    }
  );
}