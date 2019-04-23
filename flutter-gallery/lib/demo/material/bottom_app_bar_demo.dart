import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

class BottomAppBarDemo extends StatefulWidget {
  static const String routeName = '/material/bottom_app_bar';

  @override
  State<StatefulWidget> createState() {
    return _BottomAppBarDemoState();
  }
}

class _ChoiceValue<T> {
  const _ChoiceValue({this.value, this.title, this.label});

  final T value;
  final String title;
  final String label;

  @override
  String toString() {
    return '$runtimeType("$title")';
  }
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  static const _ChoiceValue<Widget> noFab = _ChoiceValue(
      title: 'None',
      label: 'do not show a floating action button',
      value: null
  );

  static const _ChoiceValue<Widget> circularFab = _ChoiceValue(
    title: 'Circular',
    label: 'circular floating action button',
    value: FloatingActionButton(
      onPressed: _showSnackBar,
      child: Icon(Icons.add, semanticLabel: 'Action',),
      backgroundColor: Colors.orange,
    )
  );

  static const _ChoiceValue<Widget> diamondFab = _ChoiceValue(
      title: 'Diamond',
      label: 'diamond shape floating action button',
      value: _DiamondFab(
        onPressed: _showSnackBar,
        child: Icon(Icons.add, semanticLabel: 'Action',),
      )
  );

  static void _showSnackBar() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(
        "When the Scaffold's floating action button location changes, "
        'the floating action button animates to its new position.'
        'The BottomAppBar adapts its shape appropriately.'
    )));
  }

  static const _ChoiceValue<FloatingActionButtonLocation> fabEndDocked = _ChoiceValue<FloatingActionButtonLocation>(
    title: 'Attached - End',
    label: 'floating action button is docked at the end of the bottom app bar',
    value: FloatingActionButtonLocation.endDocked,
  );

  static const _ChoiceValue<FloatingActionButtonLocation> fabCenterDocked = _ChoiceValue<FloatingActionButtonLocation>(
    title: 'Attached - Center',
    label: 'floating action button is docked at the center of the bottom app bar',
    value: FloatingActionButtonLocation.centerDocked,
  );

  static const _ChoiceValue<FloatingActionButtonLocation> fabEndFloat= _ChoiceValue<FloatingActionButtonLocation>(
    title: 'Free - End',
    label: 'floating action button floats above the end of the bottom app bar',
    value: FloatingActionButtonLocation.endFloat,
  );

  static const _ChoiceValue<FloatingActionButtonLocation> fabCenterFloat = _ChoiceValue<FloatingActionButtonLocation>(
    title: 'Free - Center',
    label: 'floating action button is floats above the center of the bottom app bar',
    value: FloatingActionButtonLocation.centerFloat,
  );

  static const List<_NamedColor> babColors = [
    _NamedColor(null, 'Clear'),
    _NamedColor(Color(0xFFFFC100), 'Orange'),
    _NamedColor(Color(0xFF91FAFF), 'Light Blue'),
    _NamedColor(Color(0xFF00D1FF), 'Cyan'),
    _NamedColor(Color(0xFF00BCFF), 'Cerulean'),
    _NamedColor(Color(0xFF009BEE), 'Blue'),
  ];

  static const _ChoiceValue<bool> showNotchTrue = _ChoiceValue<bool>(
    title: 'On',
    label: 'show bottom appbar notch',
    value: true,
  );

  static const _ChoiceValue<bool> showNotchFalse = _ChoiceValue<bool>(
    title: 'Off',
    label: 'do not show bottom appbar notch',
    value: false,
  );

  _ChoiceValue<Widget> _fabShape = circularFab;
  _ChoiceValue<FloatingActionButtonLocation> _fabLocation = fabEndDocked;
  _ChoiceValue<bool> _showNotch = showNotchTrue;
  Color _babColor = babColors.first.color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Bottom app bar'),
        elevation: 0,
        actions: <Widget>[
          MaterialDemoDocumentationButton(BottomAppBarDemo.routeName),
          IconButton(
            icon: Icon(Icons.sentiment_very_satisfied, semanticLabel: 'Update shape',),
            onPressed: (){
              setState(() {
                _fabShape = _fabShape == circularFab ? diamondFab : circularFab;
              });
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 88.0),
        children: <Widget>[
          _Heading('FAB Shape'),
          _RadioItem<Widget>(circularFab, _fabShape, _onFabShapeChanged),
          _RadioItem<Widget>(diamondFab, _fabShape, _onFabShapeChanged),
          _RadioItem<Widget>(noFab, _fabShape, _onFabShapeChanged),

          const Divider(),
          const _Heading('Notch'),
          _RadioItem<bool>(showNotchTrue, _showNotch, _onShowNotchChanged),
          _RadioItem<bool>(showNotchFalse, _showNotch, _onShowNotchChanged),

          const Divider(),
          const _Heading('FAB Position'),
          _RadioItem<FloatingActionButtonLocation>(fabEndDocked, _fabLocation, _onFabLocationChanged),
          _RadioItem<FloatingActionButtonLocation>(fabCenterDocked, _fabLocation, _onFabLocationChanged),
          _RadioItem<FloatingActionButtonLocation>(fabEndFloat, _fabLocation, _onFabLocationChanged),
          _RadioItem<FloatingActionButtonLocation>(fabCenterFloat, _fabLocation, _onFabLocationChanged),

          const Divider(),
          const _Heading('App bar color'),
          _ColorsItem(babColors, _babColor, _onBabColorChanged),
        ],
      ),
      floatingActionButton: _fabShape.value,
      floatingActionButtonLocation: _fabLocation.value,
      bottomNavigationBar: _DemoBottomAppBar(
        color: _babColor,
        fabLocation: _fabLocation.value,
        shape: _selectNotch(),
      ),
    );
  }

  NotchedShape _selectNotch() {
    if (!_showNotch.value)
      return null;
    if (_fabShape == circularFab)
      return CircularNotchedRectangle();
    if (_fabShape == diamondFab)
      return _DiamondNotchedRectangle();
    return null;
  }

  void _onFabShapeChanged(_ChoiceValue<Widget> value) {
    setState(() {
      _fabShape = value;
    });
  }

  void _onShowNotchChanged(_ChoiceValue<bool> value) {
    setState(() {
      _showNotch = value;
    });
  }

  void _onFabLocationChanged(_ChoiceValue<FloatingActionButtonLocation> value) {
    setState(() {
      _fabLocation = value;
    });
  }

  void _onBabColorChanged(Color value) {
    setState(() {
      _babColor = value;
    });
  }
}

class _DiamondNotchedRectangle implements NotchedShape {
  const _DiamondNotchedRectangle();

  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (!host.overlaps(guest))
      return Path()..addRect(host);
    assert(guest.width > 0.0);

    final Rect intersection = guest.intersect(host);
    final double notchToCenter =
        intersection.height * (guest.height / 2.0)
            / (guest.width / 2.0);
    print('host $host');
    print('guest $guest');
    print('intersection $intersection');
    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(guest.center.dx - notchToCenter, host.top)
      ..lineTo(guest.left + guest.width / 2.0, guest.bottom)
      ..lineTo(guest.center.dx + notchToCenter, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    this.color,
    this.fabLocation,
    this.shape
  });

  final Color color;
  final FloatingActionButtonLocation fabLocation;
  final NotchedShape shape;

  static final List<FloatingActionButtonLocation> centerLocations = [
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowContents = [
      IconButton(
        icon: Icon(Icons.menu, semanticLabel: 'Show bottom sheet',),
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) => _DemoDrawer());
        },
      )
    ];
    if (centerLocations.contains(fabLocation)) {
      rowContents.add(Expanded(child: SizedBox()));
    }

    rowContents.addAll([
      IconButton(
        icon: Icon(Icons.search, semanticLabel: 'show search action',),
        onPressed: (){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('This is a dummy search action.')));
        },
      ),
      IconButton(
        icon: Icon(
          Theme.of(context).platform == TargetPlatform.iOS
            ? Icons.more_horiz : Icons.more_vert,
          semanticLabel: 'show menu actions',),
        onPressed: (){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('This is a dummy menu action.')));
        },
      )
    ]);
    return BottomAppBar(
      color: color,
      child: Row(children: rowContents,),
      shape: shape,
    );
  }
}

class _DemoDrawer extends StatelessWidget {
  const _DemoDrawer();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
          ),
          ListTile(
            leading: Icon(Icons.threed_rotation),
            title: Text('3D'),
          )
        ],
      ),
    );
  }
}

class _DiamondFab extends StatelessWidget {
  const _DiamondFab({
    this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: _DiamondBorder(),
      color: Colors.orange,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 56,
          height: 56,
          child: IconTheme.merge(
            data: IconThemeData(color: Theme.of(context).accentIconTheme.color),
            child: child
          ),
        ),
      ),
      elevation: 6.0,
    );
  }
}

class _DiamondBorder extends ShapeBorder {
  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width  / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }

}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 48.0,
      padding: EdgeInsetsDirectional.only(start: 56.0),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: theme.textTheme.body1.copyWith(color: theme.primaryColor),
      ),
    );
  }
}

class _NamedColor {
  const _NamedColor(this.color, this.name);

  final Color color;
  final String name;
}

class _RadioItem<T> extends StatelessWidget {
  final _ChoiceValue<T> value;
  final _ChoiceValue<T> groupValue;
  final ValueChanged<_ChoiceValue<T>> onChanged;

  const _RadioItem(this.value, this.groupValue, this.onChanged);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 56.0,
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      alignment: AlignmentDirectional.centerStart,
      child: MergeSemantics(
        child: Row(
          children: <Widget>[
            Radio<_ChoiceValue<T>>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            Expanded(
              child: Semantics(
                container: true,
                button: true,
                label: value.label,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){onChanged(value);},
                  child: Text(
                    value.title,
                    style: theme.textTheme.subhead,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ColorsItem extends StatelessWidget {
  const _ColorsItem(this.colors, this.selectedColor, this.onChanged);

  final List<_NamedColor> colors;
  final Color selectedColor;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colors.map<Widget>((_NamedColor namedColor) {
        return RawMaterialButton(
          onPressed: ()=>onChanged(namedColor.color),
          constraints: BoxConstraints.tightFor(width: 32.0, height: 32.0),
          fillColor: namedColor.color,
          shape: CircleBorder(
            side: BorderSide(
              color: namedColor.color == selectedColor ? Colors.black : Color(0xFFD5D7DA),
              width: 2.0
            )
          ),
          child: Semantics(
            value: namedColor.name,
            selected: namedColor.color == selectedColor,
          ),
        );
      }).toList(),
    );
  }
}