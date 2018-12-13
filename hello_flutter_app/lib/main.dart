// 引入 UI 库
import 'package:flutter/material.dart'; 

// main 入口方法，进入 MyApp
// 单行调用使用 “=> 函数”
// void main() => runApp(MyApp()); 
void main() {
  runApp(MyApp(
    // items: List()
    // items: [1, 2, 3]
    // items: List<String>()
    items: new List<String>.generate(1000, (i)=>"$i 号技师")
  ));
}

// MyApp 类继承自 StatelessWidget，@override 重写
class MyApp extends StatelessWidget {

  final List<String> items;
  // 构造函数
  MyApp({Key key, @required this.items}):super(key:key);

  @override

  // build 方法
  Widget build(BuildContext context) {
    // Material 材料 App
    return MaterialApp(
      title: 'Welcome to Flutter!',
      // Scaffold 脚手架创建
      home: Scaffold(
          // Bar
        // appBar: AppBar(
        //     title: Text('Flutter'),
        // ),
        appBar: new AppBar(title: new Text('ListView Widget')),
        body: GridViewList()
        )
    );
  }
}

class TextWidget extends StatelessWidget{
  @override

  Widget build(BuildContext){
    return Text(
        'Hello Word?! 🤪，我是一个专门展示文本的东西，额，我应该被称作组件...',
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.0,
          color: Color.fromARGB(255, 255, 125, 125),
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.solid,
        ),
    );
  }
}

class LinearGradientContainer extends StatelessWidget{
  @override

  Widget build(BuildContext){
    return Container(
        child: new Text('Hello Flutter \n🤪🤪🤪🤪🤪🤪', style: TextStyle(fontSize: 38.0),),
        alignment: Alignment.topCenter,
        width: 500.0,
        height: 400.0,
        // color: Colors.lightBlue,
        padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        margin: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.greenAccent, Colors.lightBlue, Colors.purpleAccent]
          ),
          border: Border.all(width: 2.0, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(15.0)
        ),
    );
  }
}

class NetworkImage extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return new Image.network(
      'http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-11-16/77393802.jpg',
      fit: BoxFit.contain,
      color: Colors.greenAccent,
      colorBlendMode: BlendMode.multiply,
      repeat: ImageRepeat.repeat,
    );
  }
}

class HorizontalList extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          width: 180.0,
          color: Colors.lightBlue,
        ),
        new Container(
          width: 180.0,
          color: Colors.yellowAccent,
        ),
        new Container(
          width: 180.0,
          color: Colors.deepOrange,
        ),
        new Container(
          width: 180.0,
          color: Colors.purpleAccent,
        ),
      ]
    );
  }
}

class VerticalList extends StatelessWidget{
  @override
  
  Widget build(BuildContext context){
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.perm_camera_mic),
            title: new Text('perm_camera_mic'),
          ),
          new ListTile(
            leading: new Icon(Icons.add_call),
            title: new Text('add_call'),
          ),
          new ListTile(
            leading: new Icon(Icons.access_time),
            title: new Text('access_time'),
          ),
          new ListTile(
            leading: new Icon(Icons.add_box),
            title: new Text('add_box'),
          )
      ],
    );
  }
}

class VerticalImageList extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
          new Image.network('http://jspang.com/static/upload/20181109/1bHNoNGpZjyriCNcvqdKo3s6.jpg'),
          new Image.network('http://jspang.com/static/upload/20181111/G-wj-ZQuocWlYOHM6MT2Hbh5.jpg'),
          new Image.network('http://jspang.com/static/myimg/smile-vue.jpg'),
      ],
    );
  }
}

class DataList extends StatelessWidget{

  final List<String> items;
  DataList({Key key, @required this.items}):super(key:key);

  @override

  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){
        return new ListTile(
            leading: new Icon(Icons.call),
            title: new Text('欢迎光临，${items[index]}为您服务'),
            subtitle: new Text('天上人间 恭祝您，阖家幸福'),
            trailing: new Icon(Icons.arrow_drop_down),
          );
      },
    );
  }
}

class GridViewList extends StatelessWidget{

  @override

  Widget build(BuildContext context){
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: 0.75,
      ),
      children: <Widget>[
        new Image.network('https://img3.doubanio.com/view/photo/m/public/p2368873040.jpg', fit: BoxFit.cover,),
        new Image.network('https://img3.doubanio.com/view/photo/m/public/p2508826592.jpg', fit: BoxFit.cover,),
        new Image.network('https://img3.doubanio.com/view/photo/m/public/p2508826873.jpg', fit: BoxFit.cover,),
        new Image.network('https://img3.doubanio.com/view/photo/m/public/p2508826863.jpg', fit: BoxFit.cover,),
        new Image.network('https://img1.doubanio.com/view/photo/m/public/p2508826727.jpg', fit: BoxFit.cover,),
      ],
    );
  }
}