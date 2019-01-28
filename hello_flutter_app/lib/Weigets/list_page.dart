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
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.format_align_center),
              title: Text('Flow List'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FlowLayoutList()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.open_in_browser),
              title: Text('Expansion List'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ExpansionList()));
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

class FlowLayoutList extends StatefulWidget {
  @override
  _FlowLayoutListState createState() => _FlowLayoutListState();
}

class _FlowLayoutListState extends State<FlowLayoutList> {
  List<Widget> list;
  @override
  void initState() {
    super.initState();
    list = List<Widget>()..add(buildAddButton());
  }

  Widget buildAddButton() {
    return GestureDetector(
      onTap: () {
        if (list.length < 9) {
          setState(() {
            list.insert(list.length - 1, buildPhoto());
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80.0,
          height: 80.0,
          color: Colors.black,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildPhoto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80.0,
        height: 80.0,
        color: Colors.amberAccent,
        child: Center(
          child: Text('照片'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FlowLayout',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Opacity(
          opacity: 0.8,
          child: Container(
            padding: const EdgeInsets.all(6),
            width: width,
            height: height,
            color: Colors.grey.shade300,
            child: Wrap(
              children: list,
              spacing: 20.0,
            ),
          ),
        ),
      )),
    );
  }
}

class ExpansionStateBean {
  var isOpen;
  var index;
  ExpansionStateBean(this.index, this.isOpen);
}

// 列表 Expansion
class ExpansionList extends StatefulWidget {
  @override
  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  List<int> mList;
  List<ExpansionStateBean> expandStateList;

  _ExpansionListState() {
    mList = new List();
    expandStateList = new List();

    for (int i = 0; i < 10; i++) {
      mList.add(i);
      expandStateList.add(ExpansionStateBean(i, false));
    }
  }

  _setCurrentIndex(int index, isExpand) {
    setState(() {
      expandStateList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !isExpand;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expansion List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, bol) {
            _setCurrentIndex(index, bol);
          },
          children: mList.map((index) {
            return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text('This is No.$index'),
                  );
                },
                body: ListTile(
                  title: Text('你看到我拉🌶🌶🌶$index'),
                ),
                isExpanded: expandStateList[index].isOpen);
          }).toList(),
        ),
      ),
    );
  }
}

// 单条 Expansion
class ExpansionHome extends StatefulWidget {
  @override
  _ExpansionHomeState createState() => _ExpansionHomeState();
}

class _ExpansionHomeState extends State<ExpansionHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Closed'),
        elevation: 0.0,
      ),
      body: Center(
        child: ExpansionTile(
          title: Text('点我展开'),
          leading: Icon(Icons.ac_unit),
          backgroundColor: Colors.white12,
          initiallyExpanded: false,
          children: <Widget>[
            ListTile(
              title: Text('你看到我啦'),
              subtitle: Text('我是副标题 🌶 🌶 🌶'),
            )
          ],
        ),
      ),
    );
  }
}
