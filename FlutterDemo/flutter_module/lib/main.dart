import 'package:flutter/material.dart'; 

void main() {
  runApp(MyApp(
    items: new List<String>.generate(1000, (i)=>"$i 号技师")
  ));
}

class MyApp extends StatelessWidget {

  final List<String> items;
  MyApp({Key key, @required this.items}):super(key:key);

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter!',
      home: Scaffold(
        appBar: new AppBar(title: new Text('Flutter Navigation')),
        body: Navigation()
        )
    );
  }
}

class Navigation extends StatelessWidget{

  @override

  Widget build(BuildContext context){

    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
        child: Text('查看技师资料'),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> SecondScreenPage()
          ));
        },
        ),
        RaisedButton(
        child: Text('返回'),
        onPressed: (){
        },
      ),
      ],
    ),
    );
  }
}

// 导航详情页
class SecondScreenPage extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('技师资料')),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}