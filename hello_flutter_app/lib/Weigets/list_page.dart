import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.vertical_align_center),
              title: Text('Vertical List'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VerticalListPage()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.compare_arrows),
              title: Text('Cross List'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CrossListPage()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.perm_contact_calendar),
              title: Text('Grid List'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => GridViewList()));
            },
          ),
        ],
      ),
    );
  }
}

// 卡片列表
class GridViewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 0.75,
        ),
        children: <Widget>[
          Image.network(
            'https://img3.doubanio.com/view/photo/m/public/p2368873040.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://img3.doubanio.com/view/photo/m/public/p2508826592.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://img3.doubanio.com/view/photo/m/public/p2508826873.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://img3.doubanio.com/view/photo/m/public/p2508826863.jpg',
            fit: BoxFit.cover,
          ),
          Image.network(
            'https://img1.doubanio.com/view/photo/m/public/p2508826727.jpg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class CrossListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 180.0,
            color: Colors.lightBlue,
          ),
          Container(
            width: 180.0,
            color: Colors.yellowAccent,
          ),
          Container(
            width: 180.0,
            color: Colors.deepOrange,
          ),
          Container(
            width: 180.0,
            color: Colors.purpleAccent,
          ),
        ],
      ),
    );
  }
}

class VerticalListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: DataList(
        items: List<String>.generate(1000, (i) => "$i 号技师"),
      ),
    );
  }
}

class DataList extends StatelessWidget {
  final List<String> items;
  DataList({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.call),
          title: Text('欢迎光临，${items[index]}为您服务'),
          subtitle: Text('天上人间 恭祝您，阖家幸福'),
          trailing: Icon(Icons.group_add),
        );
      },
    );
  }
}
