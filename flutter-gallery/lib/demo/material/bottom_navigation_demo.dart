import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

class BottomNavigationDemo extends StatefulWidget {
  static const String routeName = '/material/bottom_navigation';

  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
        icon: Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.deepPurple,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: CustomIcon(),
        icon: CustomInactiveIcon(),
        title: 'Box',
        color: Colors.deepOrange,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.cloud),
        icon: const Icon(Icons.cloud_queue),
        title: 'Cloud',
        color: Colors.teal,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.favorite),
        icon: const Icon(Icons.favorite_border),
        title: 'Favorites',
        color: Colors.indigo,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Event',
        color: Colors.pink,
        vsync: this,
      )
    ];
    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar navBar = BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view){
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (i) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = i;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom navigation'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(BottomNavigationDemo.routeName),
          PopupMenuButton<BottomNavigationBarType>(
            onSelected: (value){
              setState(() {
                _type = value;
              });
            },
            itemBuilder: (context) {
              return <PopupMenuItem<BottomNavigationBarType>>[
                PopupMenuItem(
                  value: BottomNavigationBarType.fixed,
                  child: Text('Fixed'),
                ),
                PopupMenuItem(
                  value: BottomNavigationBarType.shifting,
                  child: Text('Shifting'),
                )
              ];
            },
          )
        ],
      ),
      body: Center(
          child: _buildTransitionsStack()
      ),
      bottomNavigationBar: navBar,
    );
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = [];
    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    transitions.sort((FadeTransition a, FadeTransition b) {
      Animation<double> aAnim = a.opacity;
      Animation<double> bAnim = b.opacity;
      return aAnim.value.compareTo(bAnim.value);
    });
    return Stack(children: transitions,);
  }
}

class NavigationIconView {
  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
      _color = color,
      _title = title,
      item = BottomNavigationBarItem(
        icon: icon,
        activeIcon: activeIcon,
        title: Text(title),
        backgroundColor: color
      ),
      controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync: vsync
      ) {
        _animation = controller.drive(CurveTween(curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));
      }

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting)
      iconColor = _color;
    else {
      ThemeData theme = Theme.of(context);
      iconColor = theme.brightness == Brightness.light ? theme.primaryColor : theme.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: Offset(0.0, 0.2),
            end: Offset.zero
          )
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          )
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: BoxDecoration(
          border: Border.all(color: iconTheme.color, width: 2.0),
        )
    );
  }
}