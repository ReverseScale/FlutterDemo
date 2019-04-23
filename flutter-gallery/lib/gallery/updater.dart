import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

typedef UpdateUrlFetcher = Future<String> Function();

class Updater extends StatefulWidget {
  final UpdateUrlFetcher updateUrlFetcher;
  final Widget child;

  const Updater({ @required this.updateUrlFetcher, this.child, Key key })
      : assert(updateUrlFetcher != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => UpdaterState();
}

class UpdaterState extends State<Updater> {
  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  static DateTime _lastUpdateCheck;

  Future<void> _checkForUpdates() async {
    if (_lastUpdateCheck != null &&
        DateTime.now().difference(_lastUpdateCheck) < const Duration(days: 1))
      return;
    _lastUpdateCheck = DateTime.now();
    final String updateUrl = await widget.updateUrlFetcher();
    if (updateUrl != null) {
      final bool wantsUpdate = await showDialog(context: context, builder: _buildDialog);
      if (wantsUpdate != null && wantsUpdate)
        launch(updateUrl);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;


  Widget _buildDialog(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
    theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);
    return AlertDialog(
      title: const Text('Update Flutter Gallery?'),
      content: Text('A newer version is available.', style: dialogTextStyle,),
      actions: <Widget>[
        FlatButton(
          child: Text('No Thanks'),
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text('Update'),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}