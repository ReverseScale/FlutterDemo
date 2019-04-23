import 'package:flutter/material.dart';

class ColorsDemo extends StatelessWidget {
  static const String routeName = '/colors'; // Used by the Gallery app.

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: allPalettes.length,
    child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Colors'),
        bottom: TabBar(
          isScrollable: true,
          tabs: allPalettes.map<Widget>((Palette palette) {
            return Tab(text: palette.name,);
          }).toList()
        ),
      ),
      body: TabBarView(children: allPalettes.map<Widget>((Palette palette) {
        return PaletteTabView(colors: palette,);
      }).toList()),
    ),
  );
}

class Palette {
  Palette({ this.name, this.primary, this.accent, this.threshold = 900});

  final String name;
  final MaterialColor primary;
  final MaterialAccentColor accent;
  final int threshold; // titles for indices > threshold are white, otherwise black

  bool get isValid => name != null && primary != null && threshold != null;
}

final List<Palette> allPalettes = [
  Palette(name: 'red', primary: Colors.red, accent: Colors.redAccent, threshold: 300),
  Palette(name: 'PINK', primary: Colors.pink, accent: Colors.pinkAccent, threshold: 200),
  Palette(name: 'PURPLE', primary: Colors.purple, accent: Colors.purpleAccent, threshold: 200),
  Palette(name: 'DEEP PURPLE', primary: Colors.deepPurple, accent: Colors.deepPurpleAccent, threshold: 200),
  Palette(name: 'INDIGO', primary: Colors.indigo, accent: Colors.indigoAccent, threshold: 200),
  Palette(name: 'BLUE', primary: Colors.blue, accent: Colors.blueAccent, threshold: 400),
  Palette(name: 'LIGHT BLUE', primary: Colors.lightBlue, accent: Colors.lightBlueAccent, threshold: 500),
  Palette(name: 'CYAN', primary: Colors.cyan, accent: Colors.cyanAccent, threshold: 600),
  Palette(name: 'TEAL', primary: Colors.teal, accent: Colors.tealAccent, threshold: 400),
  Palette(name: 'GREEN', primary: Colors.green, accent: Colors.greenAccent, threshold: 500),
  Palette(name: 'LIGHT GREEN', primary: Colors.lightGreen, accent: Colors.lightGreenAccent, threshold: 600),
  Palette(name: 'LIME', primary: Colors.lime, accent: Colors.limeAccent, threshold: 800),
  Palette(name: 'YELLOW', primary: Colors.yellow, accent: Colors.yellowAccent),
  Palette(name: 'AMBER', primary: Colors.amber, accent: Colors.amberAccent),
  Palette(name: 'ORANGE', primary: Colors.orange, accent: Colors.orangeAccent, threshold: 700),
  Palette(name: 'DEEP ORANGE', primary: Colors.deepOrange, accent: Colors.deepOrangeAccent, threshold: 400),
  Palette(name: 'BROWN', primary: Colors.brown, threshold: 200),
  Palette(name: 'GREY', primary: Colors.grey, threshold: 500),
  Palette(name: 'BLUE GREY', primary: Colors.blueGrey, threshold: 500),
];

class PaletteTabView extends StatelessWidget {
  final Palette colors;
  PaletteTabView({Key key, @required this.colors}) : assert(colors != null && colors.isValid), super(key:key);

  static const List<int> primaryKeys = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  static const List<int> accentKeys = [100, 200, 400, 700];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle whiteTextStyle = textTheme.body1.copyWith(color: Colors.white);
    final TextStyle blackTextStyle = textTheme.body1.copyWith(color: Colors.black);
    final List<Widget> colorItems = primaryKeys.map((int index) {
      return DefaultTextStyle(
        style: index > colors.threshold ? whiteTextStyle : blackTextStyle,
        child: ColorItem(index: index, color: colors.primary[index]),
      );
    }).toList();

    if (colors.accent != null) {
      colorItems.addAll(accentKeys.map((int index) {
        return DefaultTextStyle(
          style: index > colors.threshold ? whiteTextStyle : blackTextStyle,
          child: ColorItem(index: index, color: colors.accent[index], prefix: 'A',),
        );
      }).toList());
    }
    return ListView(
      itemExtent: colorItemHeight,
      children: colorItems,
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    Key key,
    @required this.index,
    @required this.color,
    this.prefix = '',
  })
      : assert(index != null),
        assert(color != null),
        assert(prefix != null),
        super(key: key);

  final int index;
  final Color color;
  final String prefix;

  String colorString() => '#${color.value.toRadixString(16).toUpperCase()}';

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        height: colorItemHeight,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        color: color,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('$prefix$index'),
              Text(colorString())
            ],
          )
        ),
      ),
    );
  }
}

const double colorItemHeight = 48.0;