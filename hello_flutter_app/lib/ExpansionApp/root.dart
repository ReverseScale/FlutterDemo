import 'package:flutter/material.dart';

class ExpansionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Closed',
      theme: ThemeData.dark(),
      home: ExpansionListHome(),
    );
  }
}

class ExpansionStateBean {
  var isOpen;
  var index;
  ExpansionStateBean(this.index, this.isOpen);
}

// 列表 Expansion
class ExpansionListHome extends StatefulWidget {
  @override
  _ExpansionListHomeState createState() => _ExpansionListHomeState();
}

class _ExpansionListHomeState extends State<ExpansionListHome> {
  List<int> mList;
  List<ExpansionStateBean> expandStateList;

  _ExpansionListHomeState() {
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
        title: Text('Expansion List'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, bol) {
            _setCurrentIndex(index,bol);
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
