import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

const String _explanatoryText =
    "When the Scaffold's floating action button changes, the new button fades and "
    'turns into view. In this demo, changing tabs can cause the app to be rebuilt '
    'with a FloatingActionButton that the Scaffold distinguishes from the others '
    'by its key.';

class _Page {
  _Page({ this.label, this.colors, this.icon });

  final String label;
  final MaterialColor colors;
  final IconData icon;

  Color get labelColor => colors != null ? colors.shade500 : Colors.grey.shade300;
  bool get fabDefined => colors != null && icon != null;
  Color get fabColor => colors.shade400;
  Icon get fabIcon => Icon(icon);
  Key get fabKey => ValueKey<Color>(fabColor);
}

final List<_Page> _allPages = [
  _Page(label: 'Blue', colors: Colors.indigo, icon: Icons.add),
  _Page(label: 'Eco', colors: Colors.green, icon: Icons.create),
  _Page(label: 'No'),
  _Page(label: 'Teal', colors: Colors.teal, icon: Icons.add),
  _Page(label: 'Red', colors: Colors.red, icon: Icons.create),
];

class TabsFabDemo extends StatefulWidget {
  static const String routeName = '/material/tabs-fab';

  @override
  _TabsFabDemoState createState() => _TabsFabDemoState();
}

class _TabsFabDemoState extends State<TabsFabDemo> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TabController _controller;
  _Page _selectedPage;
  bool _extendedButtons = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _allPages.length, vsync: this);
    _controller.addListener((){
      setState(() {
        _selectedPage = _allPages[_controller.index];
      });
    });
    _selectedPage = _allPages[0];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('FAB per tab'),
        bottom: TabBar(
          controller: _controller,
          tabs: _allPages.map((_Page page) => Tab(text: page.label.toUpperCase(),)).toList()),
        actions: <Widget>[
          MaterialDemoDocumentationButton(TabsFabDemo.routeName),
          IconButton(
            icon: Icon(Icons.sentiment_very_satisfied, semanticLabel: 'Toggle extended buttons',),
            onPressed: (){
              setState(() {
                _extendedButtons = !_extendedButtons;
              });
            },
          )
        ],
      ),
      floatingActionButton: buildFloatingActionButton(_selectedPage),
      body: TabBarView(
        controller: _controller,
        children: _allPages.map(buildTabView).toList()
      ),
    );
  }

  Widget buildTabView(_Page page) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48.0, 48.0, 48.0, 96.0),
      child: Card(
        child: Center(
          child: Text(
            page.label,
            style: TextStyle(
              color: page.labelColor,
              fontSize: 32.0
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFloatingActionButton(_Page page) {
    if (!page.fabDefined)
      return null;
    if (_extendedButtons)
      return FloatingActionButton.extended(
        key: page.fabKey,
        onPressed: _showExplanatoryText,
        icon: page.fabIcon,
        label: Text(page.label),
        backgroundColor: page.fabColor,
        tooltip: 'Show explanation',
      );
    return FloatingActionButton(
      key: page.fabKey,
      onPressed: _showExplanatoryText,
      child: page.fabIcon,
      backgroundColor: page.fabColor,
      tooltip: 'Show explanation',
    );
  }



  _showExplanatoryText() {
    _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).dividerColor))
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(_explanatoryText),
        ),
      );
    });
  }
}