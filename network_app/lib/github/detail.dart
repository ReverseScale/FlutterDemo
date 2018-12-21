import 'package:flutter/material.dart';
import 'package:network_app/model/item_model.dart';

class DetailViewTab extends StatelessWidget {
  final ItemModel item;
  DetailViewTab({Key key, @required this.item}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${item.name} 库详情页'),
          bottom: TabBar(
            tabs: <Widget>[
             Tab(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Icon(Icons.code),
                   SizedBox(
                      width: 5.0,
                    ),
                   Text("Codes"),
                  ],
                )
              ),
             Tab(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Icon(Icons.query_builder),
                   SizedBox(
                      width: 5.0,
                    ),
                   Text("Issues"),
                  ],
                ),
              ),
             Tab(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Icon(Icons.merge_type),
                   SizedBox(
                      width: 5.0,
                    ),
                   Text("Pull Rqt"),
                  ],
                ),
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: <Widget>[
          CodesLayout(item: item),
          IssuesLayout(),
          PullRQTLayout()
          ],
        ),
      ),
    );
  }
}

class CodesLayout extends StatelessWidget {
  final ItemModel item;
  CodesLayout({Key key, @required this.item}):super(key:key);

  @override

  textStyle() {
  return TextStyle(color: Colors.black38, fontSize: 18.0);
  }
  Widget build(BuildContext context) {
    return Container(
            color: Colors.white,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Text(
                      "${item.description}",
                      style: textStyle(),
                    ),
                  ),
                  Row(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: RaisedButton(
                          onPressed: (){},
                          color: Colors.blue[100],
                          child: new Text(
                            'flutter',
                            style: TextStyle(
                            fontSize: 
                              16.0,
                              color: Colors.blue[400],
                            ),
                            ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                      ),
                      child: RaisedButton(
                        onPressed: (){},
                        color: Colors.blue[100],
                        child: new Text(
                          'dart',
                          style: TextStyle(
                          fontSize: 
                            16.0,
                            color: Colors.blue[400],
                          ),
                          ),
                      ),
                    ),
                    ]
                  ),
                  Image.network('http://jspang.com/static/upload/20181109/1bHNoNGpZjyriCNcvqdKo3s6.jpg'),
                  Divider(),
                  Text(
                    'Flutter is Google’s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.  Flutters hot reload helps you quickly and easily experiment, build UIs, add features, and fix bugs. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android. Quickly ship features with a focus on native end-user experiences. Layered architecture allows full customization, which results in incredibly fast rendering and expressive and flexible designs.',
                    textAlign: TextAlign.start,
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                    )
                  ),
                  Image.network('https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/tools/android-studio/hot-reload.gif'),
                  Text(
                    'Delight your users with Flutter built-in beautiful Material Design and Cupertino (iOS-flavor) widgets, rich motion APIs, smooth natural scrolling, and platform awareness.',
                    textAlign: TextAlign.start,
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                    )
                  ),
                ],
              )
           );
  }
}

class IssuesLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    var card = Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Feature request: map taps listener and makrer drag location update'),
            subtitle: Text('#25439 opened 7 hours ago by AmitToren '),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/50339680.jpg'),
          ),
          Divider(),
          ListTile(
            title: Text('Webview issue with keyboard'),
            subtitle: Text('#25436 opened 10 hours ago by DevFatani'),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/50339680.jpg'),
          ),
          Divider(),
          ListTile(
            title: Text('Timer is randomly delayed when device is locked'),
            subtitle: Text('#25435 opened 12 hours ago by kevincherryholme'),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/50339680.jpg'),
          ),
          Divider(),
          ListTile(
            title: Text('building for ios without build number tool'),
            subtitle: Text('#25401 opened 2 days ago by RobinManoli'),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/50339680.jpg'),
          ),
          Divider(),
          ListTile(
            title: Text('[Wiki] Obfuscating-Dart-Code page on wiki "xcode_backend.sh" path error'),
            subtitle: Text('#25400 opened 2 days ago by thatzjy'),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/50339680.jpg'),
          ),
        ],
      ),
    );

    return Center(
      child: card,
    );
  }
}


class PullRQTLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    var card = Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Test Do not Merge'),
            subtitle: Text('Opened by gpeal about 2 hours age'),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/35746533.jpg'),
          ),
          Divider(),
          ListTile(
            title: Text('Added possibility to modift standard task listeners'),
            subtitle: Text('Opened by iismagilov 2 months age'),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/35746533.jpg'),
          ),
          Divider(),
          ListTile(
            title: Text('Fix texttransform when used with other text styles on Android'),
            subtitle: Text('Opened by iismagilov 2 years age'),
            leading: Image.network('http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/35746533.jpg'),
          ),
        ],
      ),
    );

    return Center(
      child: card,
    );
  }
}