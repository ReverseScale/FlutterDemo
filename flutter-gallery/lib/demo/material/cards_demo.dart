import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

class CardsDemo extends StatefulWidget {
  static const String routeName = '/material/cards';

  @override
  _CardsDemoState createState() => _CardsDemoState();
}

class TravelDestination {
  const TravelDestination({
    this.assetName,
    this.assetPackage,
    this.title,
    this.description,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final List<String> description;

  bool get isValid => assetName != null && title != null && description?.length == 3;
}

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

final List<TravelDestination> destinations = <TravelDestination>[
  const TravelDestination(
    assetName: 'places/india_thanjavur_market.png',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Top 10 Cities to Visit in Tamil Nadu',
    description: <String>[
      'Number 10',
      'Thanjavur',
      'Thanjavur, Tamil Nadu',
    ],
  ),
  const TravelDestination(
    assetName: 'places/india_chettinad_silk_maker.png',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Artisans of Southern India',
    description: <String>[
      'Silk Spinners',
      'Chettinad',
      'Sivaganga, Tamil Nadu',
    ],
  )
];

class TravelDestinationItem extends StatelessWidget {
  TravelDestinationItem({ Key key, @required this.destination, this.shape })
      : assert(destination != null && destination.isValid),
        super(key: key);

  static const double height = 366.0;
  final TravelDestination destination;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descStyle = theme.textTheme.subhead;

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: height,
        child: Card(
          shape: shape,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 184.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(destination.assetName, package: destination.assetPackage, fit: BoxFit.cover,),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(destination.title, style: titleStyle,)),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                    style: descStyle,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(destination.description[0], style: descStyle.copyWith(color: Colors.black54),),
                        ),
                        Text(destination.description[1]),
                        Text(destination.description[2]),
                      ],
                    ),
                  ),
                ),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child: Text('SHARE', semanticsLabel: 'Share ${destination.title}'),
                      textColor: Colors.amber.shade500,
                      onPressed: () { /* do nothing */ },
                    ),
                    FlatButton(
                      child: Text('EXPLORE', semanticsLabel: 'Explore ${destination.title}'),
                      textColor: Colors.amber.shade500,
                      onPressed: () { /* do nothing */ },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CardsDemoState extends State<CardsDemo> {
  ShapeBorder _shape;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel stream'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(CardsDemo.routeName),
          IconButton(
            icon: Icon(Icons.sentiment_very_satisfied, semanticLabel: 'update shape',),
            onPressed: (){
              setState(() {
                _shape = _shape != null ? null : RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  )
                );
              });
            },
          )
        ],
      ),
      body: ListView(
        itemExtent: TravelDestinationItem.height,
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        children: destinations.map((TravelDestination dest) => Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child: TravelDestinationItem(
            destination: dest,
            shape: _shape,
          ))).toList()
      ),
    );
  }
}