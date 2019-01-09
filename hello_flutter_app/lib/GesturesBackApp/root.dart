import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class GesturesBackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GesturesBack',
      theme: ThemeData.light(),
      home: GesturesBackHome(),
    );
  }
}

class GesturesBackHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('GesturesBack'),
      ),
      child: Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          color: CupertinoColors.activeBlue,
          child: CupertinoButton(
            child: Icon(CupertinoIcons.add),
            onPressed: (){
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context){
                    return NextPage();
                  }
                )
              );
            },
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Next Page'),
        leading: GestureDetector(
          child: Icon(CupertinoIcons.back),
          onTap: (){
            Navigator.pop(context);
          },
        )
      ),
      child: Center(
        child: Text('Welcome')
      ),
    );
  }
}