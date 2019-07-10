import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../model/search_model.dart';
import '../model/item_model.dart';
import '../page/detail.dart';
import '../provider/provider.dart';

class MyApp extends StatelessWidget {
  final ThemeData kIOSTheme = ThemeData(
    //Cupertino主题风格
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData kDefaultTheme = ThemeData(
    //默认的Material主题风格
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTargetPlatform ==
              TargetPlatform.iOS // defaultTargetPlatform用于识别操作系统
          ? kIOSTheme //
          : kDefaultTheme,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  ProviderBlock _blocProvider = ProviderBlock.instance();

  @override
  void initState() {
    super.initState();
    _blocProvider.fetchQueryList();
  }

  @override
  void dispose() {
    _blocProvider.dispose();
    super.dispose();
  }

  void finished() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Github List Sample"),
          elevation: Theme.of(context).platform == TargetPlatform.iOS
              ? 0.0
              : 4.0, //  适配IOS的扁平化无阴影效果
        ),
        body: Container(
          child: buildBody(),
          decoration:
              Theme.of(context).platform == TargetPlatform.iOS //    加入主题风格
                  ? BoxDecoration(
                      border: Border(
                        //  为适应IOS加入边框特性
                        top: BorderSide(color: Colors.grey[200]), //  顶部加入灰色边框
                      ),
                    )
                  : null,
        ));
  }

  Widget buildData() {
    return _blocProvider.streamBuilder<SearchModel>(
        success: (data) {
          return buildList(data);
        },
        error: (msg) {
          return Container(
            child: Center(
              child: Text(msg),
            ),
          );
        },
        empty: () {
          return Container(
            child: Center(
              child: Text("暂无数据"),
            ),
          );
        },
        loading: () {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        finished: finished);
  }

  Widget buildList(SearchModel data) {
    return ListView.builder(
      itemCount: data.items.length,
      itemBuilder: (context, index) {
        ItemModel itemModel = data.items[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailViewTab(item: data.items[index])));
          },
          child: Card(
            margin: EdgeInsets.only(
              left: 15.0,
              top: 15.0,
              right: 15.0,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 10.0,
                  ),
                  child: Text(itemModel.name,
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 18.0,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Text(
                    itemModel.description,
                    style: TextStyle(
                      color: Color(0xff9b9b9b),
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                        ),
                        child: Image.network(
                          'http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/50356447.jpg',
                          width: 16.0,
                          height: 16.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text("${itemModel.watchers}",
                            style: TextStyle(
                              color: Color(0xff9b9b9b),
                              fontSize: 14.0,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                        ),
                        child: Image.network(
                          'http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/17357054.jpg',
                          width: 16.0,
                          height: 16.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text("${itemModel.forks}",
                            style: TextStyle(
                              color: Color(0xff9b9b9b),
                              fontSize: 14.0,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBody() {
    return buildData();
  }
}
