import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackdropDemo extends StatefulWidget {
  static const String routeName = '/material/backdrop'; // Used by the Gallery app.

  @override
  State<StatefulWidget> createState() {
    return _BackdropDemoState();
  }
}

class _BackdropDemoState extends State<BackdropDemo> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Category _category = allCategories.first;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: BackdropTitle(listenable: _controller.view,),
        actions: <Widget>[
          IconButton(
            onPressed: _toggleBackdropPanelVisibility,
            icon: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller.view,
              semanticLabel: 'close',
            ),
          )
        ],
      ),
      body: LayoutBuilder(builder: _buildStack),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    final Animation<RelativeRect> panelAnimation = _controller.drive(
      RelativeRectTween(
        begin: RelativeRect.fromLTRB(0, panelTop - MediaQuery.of(context).padding.bottom, 0, panelTop - panelSize.height),
        end: RelativeRect.fromLTRB(0, 0, 0, 0)
      )
    );
    panelAnimation.addListener((){
      print('orig=${_controller.view.value} panelAnimation=${panelAnimation.value}');
    });

    final ThemeData theme = Theme.of(context);
    final List<Widget> backdropItems = allCategories.map<Widget>((Category category) {
      final bool selected = category == _category;
      return Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))
        ),
        color: selected ? Colors.white.withOpacity(0.25) : Colors.transparent,
        child: ListTile(
          title: Text(category.title),
          selected: selected,
          onTap: (){
            _changeCategory(category);
          },
        ),
      );
    }).toList();

    return Container(
      key: _backdropKey,
      color: theme.primaryColor,
      child: Stack(
        children: <Widget>[
          ListTileTheme(
            iconColor: theme.primaryIconTheme.color,
            textColor: theme.primaryTextTheme.title.color.withOpacity(0.6),
            selectedColor: theme.primaryTextTheme.title.color,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: backdropItems,
              ),
            ),
          ),
          PositionedTransition(
            rect: panelAnimation,
            child: BackdropPanel(
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              title: Text(_category.title),
              child: CategoryView(category: _category),
            ),
          )
        ],
      ),
    );
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;
    _controller.value -= details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;
    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  _changeCategory(Category category) {
    setState(() {
      _category = category;
      _controller.fling(velocity: 2.0);
    });
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }
}
class Category {
  final String title;
  final List<String> assets;

  const Category({this.title, this.assets});

  @override
  String toString() {
    return '$runtimeType($title)';
  }
}

const List<Category> allCategories = [
  Category(
    title: 'Accessories',
    assets: <String>[
      'products/belt.png',
      'products/earrings.png',
      'products/backpack.png',
      'products/hat.png',
      'products/scarf.png',
      'products/sunnies.png',
    ],
  ),
  Category(
    title: 'Blue',
    assets: <String>[
      'products/backpack.png',
      'products/cup.png',
      'products/napkins.png',
      'products/top.png',
    ],
  ),
  Category(
    title: 'Cold Weather',
    assets: <String>[
      'products/jacket.png',
      'products/jumper.png',
      'products/scarf.png',
      'products/sweater.png',
      'products/sweats.png',
    ],
  ),
  Category(
    title: 'Home',
    assets: <String>[
      'products/cup.png',
      'products/napkins.png',
      'products/planters.png',
      'products/table.png',
      'products/teaset.png',
    ],
  ),
  Category(
    title: 'Tops',
    assets: <String>[
      'products/jumper.png',
      'products/shirt.png',
      'products/sweater.png',
      'products/top.png',
    ],
  ),
  Category(
    title: 'Everything',
    assets: <String>[
      'products/backpack.png',
      'products/belt.png',
      'products/cup.png',
      'products/dress.png',
      'products/earrings.png',
      'products/flatwear.png',
      'products/hat.png',
      'products/jacket.png',
      'products/jumper.png',
      'products/napkins.png',
      'products/planters.png',
      'products/scarf.png',
      'products/shirt.png',
      'products/sunnies.png',
      'products/sweater.png',
      'products/sweats.png',
      'products/table.png',
      'products/teaset.png',
      'products/top.png',
    ],
  ),
];

class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({Key key, Listenable listenable}) : super(key:key, listenable:listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    Animation<double> anim1 = CurvedAnimation(
        parent: ReverseAnimation(animation),
        curve: const Interval(0.5, 1.0)
    );

    Animation<double> anim2 = CurvedAnimation(
        parent: animation,
        curve: const Interval(0.5, 1.0)
    );

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: anim1.value            ,
            child: const Text('Select a Category'),
          ),
          Opacity(
            opacity: anim2.value,
            child: Text('Asset Viewer'),
          )
        ],
      ),
    );
  }
}

class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      elevation: 2.0,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            onTap: onTap,
            child: Container(
              height: 48.0,
              padding: EdgeInsetsDirectional.only(start: 16.0),
              alignment: AlignmentDirectional.centerStart,
              child: DefaultTextStyle(style: theme.textTheme.subhead, child: Tooltip(message: 'Tap to dismiss', child: title,)),
            ),
          ),
          Divider(height: 1.0,),
          Expanded(child: child,)
        ],
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({ Key key, this.category }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView(
      key: PageStorageKey(category),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
      children: category.assets.map<Widget>((String asset) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Container(
                width: 144.0,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Image.asset(asset, package: 'flutter_gallery_assets', fit: BoxFit.contain,),
                    Container(
                      padding: EdgeInsets.only(bottom: 16.0),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        asset,
                        style: theme.textTheme.caption,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0,)
          ],
        );
      }).toList(),
    );
  }
}