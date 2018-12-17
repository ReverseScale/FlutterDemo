import 'package:flutter/material.dart';
import 'provider_block.dart';

import 'package:network_app/model/search_model.dart';
import 'package:network_app/model/item_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  ProviderBlock _blocProvider = ProviderBlock.newInstance();

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
      ),
      body: buildBody(),
    );
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
                  builder: (context) => PageDetail(item:data.items[index])
                )
              );
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
                        child: 
                          Image.network(
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
                        child: 
                          Image.network(
                            'http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/17357054.jpg',
                            width: 16.0, 
                            height: 16.0,
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text("forks:${itemModel.forks}",
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

class PageDetail extends StatelessWidget {
  final ItemModel item;
  PageDetail({Key key, @required this.item}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${item.name} 库详情页')),
      body: Center(child: Text('${item.description}')),
    );
  }
}