import 'package:flutter/material.dart';
import 'package:gallery/gallery/example_code_parser.dart';
import 'package:gallery/gallery/syntax_highlighter.dart';
import 'package:url_launcher/url_launcher.dart';

const String _raisedText =
    'Raised buttons add dimension to mostly flat layouts. They emphasize '
    'functions on busy or wide spaces.';

const String _raisedCode = 'buttons_raised';

const String _flatText = 'A flat button displays an ink splash on press '
    'but does not lift. Use flat buttons on toolbars, in dialogs and '
    'inline with padding';

const String _flatCode = 'buttons_flat';

const String _outlineText =
    'Outline buttons become opaque and elevate when pressed. They are often '
    'paired with raised buttons to indicate an alternative, secondary action.';

const String _outlineCode = 'buttons_outline';

const String _dropdownText =
    'A dropdown button displays a menu that\'s used to select a value from a '
    'small set of values. The button displays the current value and a down '
    'arrow.';

const String _dropdownCode = 'buttons_dropdown';

const String _iconText =
    'IconButtons are appropriate for toggle buttons that allow a single choice '
    'to be selected or deselected, such as adding or removing an item\'s star.';

const String _iconCode = 'buttons_icon';

const String _actionText =
    'Floating action buttons are used for a promoted action. They are '
    'distinguished by a circled icon floating above the UI and can have motion '
    'behaviors that include morphing, launching, and a transferring anchor '
    'point.';

const String _actionCode = 'buttons_action';

class ButtonsDemo extends StatefulWidget {
  static const String routeName = '/material/buttons';

  @override
  _ButtonsDemoState createState() => _ButtonsDemoState();
}

class _ButtonsDemoState extends State<ButtonsDemo> {
  ShapeBorder _buttonShape;

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonTheme = ButtonTheme.of(context).copyWith(shape: _buttonShape);
    final List<ComponentDemoTabData> demos = [
      ComponentDemoTabData(
        tabName: 'raised',
        description: _raisedText,
        demoWidget: ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildRaisedButton(),
        ),
        exampleCodeTag: _raisedCode,
        documentationUrl: 'https://docs.flutter.io/flutter/material/RaisedButton-class.html'
      ),
      ComponentDemoTabData(
        tabName: 'FLAT',
        description: _flatText,
        demoWidget: ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildFlatButton(),
        ),
        exampleCodeTag: _flatCode,
        documentationUrl: 'https://docs.flutter.io/flutter/material/FlatButton-class.html',
      ),
      ComponentDemoTabData(
        tabName: 'OUTLINE',
        description: _outlineText,
        demoWidget: ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child:
          buildOutlineButton(),
        ),
        exampleCodeTag: _outlineCode,
        documentationUrl: 'https://docs.flutter.io/flutter/material/OutlineButton-class.html',
      ),
      ComponentDemoTabData(
        tabName: 'DROPDOWN',
        description: _dropdownText,
        demoWidget: buildDropdownButton(),
        exampleCodeTag: _dropdownCode,
        documentationUrl: 'https://docs.flutter.io/flutter/material/DropdownButton-class.html',
      ),
      ComponentDemoTabData(
        tabName: 'ICON',
        description: _iconText,
        demoWidget: buildIconButton(),
        exampleCodeTag: _iconCode,
        documentationUrl: 'https://docs.flutter.io/flutter/material/IconButton-class.html',
      ),
      ComponentDemoTabData(
        tabName: 'ACTION',
        description: _actionText,
        demoWidget: buildActionButton(),
        exampleCodeTag: _actionCode,
        documentationUrl: 'https://docs.flutter.io/flutter/material/FloatingActionButton-class.html',
      ),
    ];
    return TabbedComponentDemoScaffold(
      title: 'Buttons',
      demos: demos,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.sentiment_very_satisfied, semanticLabel: 'Update shape',),
          onPressed: (){
            setState(() {
              _buttonShape = _buttonShape == null ? StadiumBorder() : null;
            });
          },
        )
      ],
    );
  }

  Widget buildActionButton() {
    return Align(
      alignment: Alignment(0, -0.2),
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
        tooltip: 'floating action button',
      ),
    );
  }

  bool iconButtonToggle = false;

  Widget buildIconButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.thumb_up,
              semanticLabel: 'Thumbs up',
            ),
            onPressed: () {
              setState(() => iconButtonToggle = !iconButtonToggle);
            },
            color: iconButtonToggle ? Theme.of(context).primaryColor : null,
          ),
          const IconButton(
            icon: Icon(
              Icons.thumb_up,
              semanticLabel: 'Thumbs not up',
            ),
            onPressed: null,
          )
        ].map((Widget button) => SizedBox(width: 64.0, height: 64.0, child: button,)).toList()
      ),
    );
  }

  String dropdown1Value = 'Free';
  String dropdown2Value;
  String dropdown3Value = 'Four';

  Widget buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Simple dropdown'),
            trailing: DropdownButton(
              value: dropdown1Value,
              items: ['One', 'Two', 'Free', 'Four'].map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              )).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdown1Value = newValue;
                });
              }
            ),
          ),
          SizedBox(height: 24.0,),
          ListTile(
            title: const Text('Dropdown with a hint:'),
            trailing: DropdownButton<String>(
              value: dropdown2Value,
              hint: const Text('Choose'),
              onChanged: (String newValue) {
                setState(() {
                  dropdown2Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: const Text('Scrollable dropdown:'),
            trailing: DropdownButton<String>(
              value: dropdown3Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown3Value = newValue;
                });
              },
              items: <String>[
                'One', 'Two', 'Free', 'Four', 'Can', 'I', 'Have', 'A', 'Little',
                'Bit', 'More', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'
              ]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRaisedButton() {
    return Column(
      children: <Widget>[
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              child: Text('Raised button', semanticsLabel: 'Raised button 1',),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text('disabled', semanticsLabel: 'disabled button 1',),
              onPressed: null,
            )
          ],
        ),
        ButtonBar(
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.add, size: 18.0,),
              label: Text('Raised button', semanticsLabel: 'Raised button 1',),
              onPressed: (){},
            ),
            RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('disabled', semanticsLabel: 'disabled button 1',),
              onPressed: null,
            )
          ],
        )
      ],
    );
  }

  Widget buildFlatButton() {
    return Align(
      alignment: Alignment(0.0, -0.2),
      child: Column(
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Text('Flat button', semanticsLabel: 'flat button 1',),
                onPressed: (){},
              ),
              FlatButton(
                child: Text('Flat button', semanticsLabel: 'flat button 2',),
                onPressed: null,
              )
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.add_circle_outline, size: 18.0,),
                label: Text('Flat button', semanticsLabel: 'flat button 1',),
                onPressed: (){},
              ),
              FlatButton.icon(
                icon: Icon(Icons.add_circle_outline, size: 18.0,),
                label: Text('Flat button', semanticsLabel: 'flat button 1',),
                onPressed: null,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOutlineButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton(
                child: const Text('OUTLINE BUTTON', semanticsLabel: 'OUTLINE BUTTON 1'),
                onPressed: () {
                  // Perform some action
                },
              ),
              const OutlineButton(
                child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 5'),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('OUTLINE BUTTON', semanticsLabel: 'OUTLINE BUTTON 2'),
                onPressed: () {
                  // Perform some action
                },
              ),
              OutlineButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 6'),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ComponentDemoTabData {
  ComponentDemoTabData({
    this.demoWidget,
    this.exampleCodeTag,
    this.description,
    this.tabName,
    this.documentationUrl,
  });

  final Widget demoWidget;
  final String exampleCodeTag;
  final String description;
  final String tabName;
  final String documentationUrl;

  @override
  bool operator ==(other) {
    if (other.runtimeType != runtimeType)
      return false;
    final ComponentDemoTabData typedOther = other;
    return typedOther.tabName == tabName
      && typedOther.description == description
      && typedOther.documentationUrl == documentationUrl;
  }

  @override
  int get hashCode => hashValues(tabName, description, documentationUrl);
}

class TabbedComponentDemoScaffold extends StatelessWidget {
  const TabbedComponentDemoScaffold({
    this.title,
    this.demos,
    this.actions,
  });

  final List<ComponentDemoTabData> demos;
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: demos.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: (actions ?? <Widget>[])..addAll(
            [
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.library_books, semanticLabel: 'Show documentation',),
                    onPressed: ()=>_showApiDocumentation(context),
                  );
                },
              ),
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.code, semanticLabel: 'Show example code',),
                    onPressed: ()=>_showExampleCode(context),
                  );
                },
              ),
            ]
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: demos.map<Widget>((ComponentDemoTabData data) => Tab(text: data.tabName,)).toList()
          ),
        ),
        body: TabBarView(
          children: demos.map((ComponentDemoTabData data) => SafeArea(
            top: false,
            right: false,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(data.description, style: Theme.of(context).textTheme.subhead,),
                ),
                data.demoWidget
              ],
            ),
          )).toList()
        ),
      ),
    );
  }

  _showApiDocumentation(context) {
    final String url = demos[DefaultTabController.of(context).index].documentationUrl;
    if (url != null)
      launch(url, forceWebView: false);
  }

  void _showExampleCode(BuildContext context) {
    final String tag = demos[DefaultTabController.of(context).index].exampleCodeTag;
    if (tag != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FullScreenCodeDialog(exampleCodeTag: tag);
      }));
    }
  }
}

class FullScreenCodeDialog extends StatefulWidget {
  const FullScreenCodeDialog({ this.exampleCodeTag });

  final String exampleCodeTag;

  @override
  State<StatefulWidget> createState() {
    return FullScreenCodeDialogState();
  }
}

class FullScreenCodeDialogState extends State<FullScreenCodeDialog> {
  String _exampleCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getExampleCode(widget.exampleCodeTag, DefaultAssetBundle.of(context))
      .then((String code) {
        if (mounted)
          setState(() {
            _exampleCode = code ?? 'Example code not found';
          });
      });
  }

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style = Theme.of(context).brightness == Brightness.dark
        ? SyntaxHighlighterStyle.darkThemeStyle()
        : SyntaxHighlighterStyle.lightThemeStyle();
    Widget body;
    if (_exampleCode == null)
      body = Center(child: CircularProgressIndicator(),);
    else
      body = SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RichText(text: TextSpan(
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
            children: [
              DartSyntaxHighlighter(style).format(_exampleCode)
            ]
          )),
        ),
      );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear, semanticLabel: 'Close',),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title: Text('Example code'),
      ),
      body: body,
    );
  }
}