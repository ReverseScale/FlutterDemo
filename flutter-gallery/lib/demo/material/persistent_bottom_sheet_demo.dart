import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

class PersistentBottomSheetDemo extends StatefulWidget {
  static const String routeName = '/material/persistent-bottom-sheet';

  @override
  _PersistentBottomSheetDemoState createState() => _PersistentBottomSheetDemoState();
}

class _PersistentBottomSheetDemoState extends State<PersistentBottomSheetDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  _showBottomSheet() {
    setState(() {
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet((context) {
      final ThemeData themeData = Theme.of(context);
      return Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: themeData.disabledColor))
        ),
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('This is a Material persistent bottom sheet. Drag downwards to dismiss it.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeData.accentColor,
              fontSize: 24.0
            ),
          ),
        ),
      );
    }).closed.whenComplete((){
      if (mounted)
        setState(() {
          _showBottomSheetCallback = _showBottomSheet;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Persistent bottom sheet'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(PersistentBottomSheetDemo.routeName),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMessage,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add, semanticLabel: 'Add',),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _showBottomSheetCallback,
          child: Text('Show bottom sheet'),
        ),
      ),
    );
  }

  _showMessage() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: Text('You tapped the floating action button.'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            )
          ],
        );
      });
  }
}