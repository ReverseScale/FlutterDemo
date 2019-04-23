import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

class ModalBottomSheetDemo extends StatelessWidget {
  static const String routeName = '/material/modal-bottom-sheet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal bottom sheet'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(routeName)
        ],
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Show bottom sheet'),
          onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              return Container(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('This is the modal bottom sheet. Tap anywhere to dismiss.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 24.0
                    ),
                  ),
                ),
              );
            });
          }
        ),
      ),
    );
  }
}