import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

const List<String> _defaultMaterials = <String>[
  'poker',
  'tortilla',
  'fish and',
  'micro',
  'wood',
];

const List<String> _defaultActions = <String>[
  'flake',
  'cut',
  'fragment',
  'splinter',
  'nick',
  'fry',
  'solder',
  'cash in',
  'eat',
];

const Map<String, String> _results = <String, String>{
  'flake': 'flaking',
  'cut': 'cutting',
  'fragment': 'fragmenting',
  'splinter': 'splintering',
  'nick': 'nicking',
  'fry': 'frying',
  'solder': 'soldering',
  'cash in': 'cashing in',
  'eat': 'eating',
};

const List<String> _defaultTools = <String>[
  'hammer',
  'chisel',
  'fryer',
  'fabricator',
  'customer',
];

const Map<String, String> _avatars = <String, String>{
  'hammer': 'people/square/ali.png',
  'chisel': 'people/square/sandra.png',
  'fryer': 'people/square/trevor.png',
  'fabricator': 'people/square/stella.png',
  'customer': 'people/square/peter.png',
};

final Map<String, Set<String>> _toolActions = {
  'hammer': Set()..addAll(['flake', 'fragment', 'splinter']),
  'chisel': Set<String>()..addAll(<String>['flake', 'nick', 'splinter']),
  'fryer': Set<String>()..addAll(<String>['fry']),
  'fabricator': Set<String>()..addAll(<String>['solder']),
  'customer': Set<String>()..addAll(<String>['cash in', 'eat']),
};

final Map<String, Set<String>> _materialActions = <String, Set<String>>{
  'poker': Set<String>()..addAll(<String>['cash in']),
  'tortilla': Set<String>()..addAll(<String>['fry', 'eat']),
  'fish and': Set<String>()..addAll(<String>['fry', 'eat']),
  'micro': Set<String>()..addAll(<String>['solder', 'fragment']),
  'wood': Set<String>()..addAll(<String>['flake', 'cut', 'splinter', 'nick']),
};

class ChipDemo extends StatefulWidget {
  static const String routeName = '/material/chip';

  @override
  _ChipDemoState createState() => _ChipDemoState();
}

class _ChipDemoState extends State<ChipDemo> {
  final Set<String> _materials = Set<String>();
  String _selectedMaterial = '';
  String _selectedAction = '';
  final Set<String> _tools = Set<String>();
  final Set<String> _selectedTools = Set<String>();
  final Set<String> _actions = Set<String>();
  bool _showShapeBorder = false;

  _ChipDemoState() {
    _reset();
  }

  void _reset() {
    _materials.clear();
    _materials.addAll(_defaultMaterials);
    _actions.clear();
    _actions.addAll(_defaultActions);
    _tools.clear();
    _tools.addAll(_defaultTools);
    _selectedMaterial = '';
    _selectedAction = '';
    _selectedTools.clear();
  }

  void _removeMaterial(String name) {
    _materials.remove(name);
    if (_selectedMaterial == name) {
      _selectedMaterial = '';
    }
  }

  void _removeTool(String name) {
    _tools.remove(name);
    _selectedTools.remove(name);
  }

  String _capitalize(String name) {
    assert(name != null && name.isNotEmpty);
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  AssetImage _nameToAvatar(String name) {
    assert(_avatars.containsKey(name));
    return AssetImage(
      _avatars[name],
      package: 'flutter_gallery_assets',
    );
  }

  String _createResult() {
    print('_createResult _selectedAction=$_selectedAction');
    if (_selectedAction.isEmpty) {
      return '';
    }
    return _capitalize(_results[_selectedAction]) + '!';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final List<Widget> chips = _materials.map((String name) => Chip(
      backgroundColor: _nameToColor(name),
      label: Text(_capitalize(name)),
      onDeleted: (){
        setState(() {
          _removeMaterial(name);
        });
      },
    )).toList();

    final List<Widget> inputChips = _tools.map((String name) => InputChip(
      avatar: CircleAvatar(backgroundImage: _nameToAvatar(name),),
      label: Text(_capitalize(name)),
      onDeleted: (){
        setState(() {
          _removeTool(name);
        });
      },
    )).toList();

    final List<Widget> choiceChips = _materials.map((String name) => ChoiceChip(
      backgroundColor: _nameToColor(name),
      label: Text(_capitalize(name)),
      selected: _selectedMaterial == name,
      onSelected: (bool value){
        setState(() {
          _selectedMaterial = value ? name : '';
        });
      },
    )).toList();

    final List<Widget> filterChips = _defaultTools.map((String name) => FilterChip(
      label: Text(_capitalize(name)),
      selected: _tools.contains(name) ? _selectedTools.contains(name) : false,
      onSelected: !_tools.contains(name) ? null : (bool value){
        setState(() {
          if (!value)
            _selectedTools.remove(name);
          else
            _selectedTools.add(name);
        });
      },
    )).toList();

    Set<String> allowedActions = Set<String>();
    if (_selectedMaterial != null && _selectedMaterial.isNotEmpty) {
      for (String tool in _selectedTools)
        allowedActions.addAll(_toolActions[tool]);
      allowedActions = allowedActions.intersection(_materialActions[_selectedMaterial]);
    }

    final List<Widget> actionChips = allowedActions.map((String name) => ActionChip(
      label: Text(_capitalize(name)),
      onPressed: (){
        setState(() {
          _selectedAction = name;
        });
      },
    )).toList();

    final List<Widget> tiles = [
      SizedBox(height: 8.0, width: 0,),
      _ChipsTile(label: 'Available Materials (Chip)', children: chips),
      _ChipsTile(label: 'Available Tools (InputChip)', children: inputChips),
      _ChipsTile(label: 'Choose a Material (ChoiceChip)', children: choiceChips),
      _ChipsTile(label: 'Choose Tools (FilterChip)', children: filterChips),
      _ChipsTile(label: 'Perform Allowed Action (ActionChip)', children: actionChips),
      const Divider(),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(_createResult(), style: theme.textTheme.title,),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Chips'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(ChipDemo.routeName),
          IconButton(
            icon: Icon(Icons.vignette, semanticLabel: 'Update border shape',),
            onPressed: (){
              setState(() {
                _showShapeBorder = !_showShapeBorder;
              });
            },
          )
        ],
      ),
      body: ChipTheme(
        data: !_showShapeBorder ? theme.chipTheme : theme.chipTheme.copyWith(
          shape: BeveledRectangleBorder(
            side: BorderSide(width: 0.66, style: BorderStyle.solid, color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          )
        ),
        child: ListView(children: tiles,)),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(_reset);
      },
      child: Icon(Icons.refresh, semanticLabel: 'Reset chips',),),
    );
  }
}

class _ChipsTile extends StatelessWidget {
  const _ChipsTile({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cardChildren = [
      Container(
        padding: EdgeInsets.only(top: 16.0, bottom: 4.0),
        alignment: Alignment.center,
        child: Text(label))
    ];

    if (children.isNotEmpty) {
      cardChildren.add(Wrap(
        children: children.map((Widget chip) => Padding(
          padding: EdgeInsets.all(2.0),
          child: chip,
        )).toList(),
      ));
    } else {
      cardChildren.add(
        Semantics(
          container: true,
          child: Container(
            constraints: BoxConstraints(minHeight: 48.0, minWidth: 48.0),
            alignment: Alignment.center,
            child: Text('None',
              style: Theme.of(context).textTheme.caption.copyWith(fontStyle: FontStyle.italic),
      ),
          ),
        ));
    }

    return Card(
      semanticContainer: false,
      child: Column(
//        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
    );
  }
}