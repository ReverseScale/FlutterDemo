import 'package:flutter/services.dart';

const String _startTag = '// START ';
const String _endTag = '// END';

Map<String, String> _exampleCode;

Future<String> getExampleCode(String tag, AssetBundle bundle) async {
  if (_exampleCode == null)
    await _parseExampleCode(bundle);
  return _exampleCode[tag];
}

Future<void> _parseExampleCode(AssetBundle bundle) async {
  final String code = await bundle.loadString('lib/gallery/example_code.dart') ??
    '// lib/gallery/example_code.dart not found\n';
  _exampleCode = {};
  final List<String> lines = code.split('\n');

  List<String> codeBlock;
  String codeTag;

  for (String line in lines) {
    if (codeBlock == null) {
      if (line.startsWith(_startTag)) {
        codeBlock = [];
        codeTag = line.substring(_startTag.length).trim();
      }
    } else {
      if (line.startsWith(_endTag)) {
        _exampleCode[codeTag] = codeBlock.join('\n');
        codeBlock = null;
        codeTag = null;
      } else {
        codeBlock.add(line.trimRight());
      }
    }
  }
}