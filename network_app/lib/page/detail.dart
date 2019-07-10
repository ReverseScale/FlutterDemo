import 'package:flutter/material.dart';
import '../model/item_model.dart';

class DetailViewTab extends StatelessWidget {
  final ItemModel item;
  DetailViewTab({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${item.name} 库详情页'),
          elevation: 0.0,
          bottom: TabBar(
            indicatorColor: Colors.blue,
            tabs: <Widget>[
              Tab(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.code),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("Codes"),
                ],
              )),
              Tab(
                child: Row(
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
              Tab(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.merge_type),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("PR"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ChildWidget(),
            ChildWidget(),
            ChildWidget()
          ],
        ),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Demo'),);
  }
}