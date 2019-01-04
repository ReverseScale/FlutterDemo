import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter_app/TabbarApp.dart';

class TabbarType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CuperHomeApp(),
    );
  }
}

class CuperHomeApp extends StatefulWidget {
  @override
  _CuperHomeAppState createState() => _CuperHomeAppState();
}

class _CuperHomeAppState extends State<CuperHomeApp> {
  int _index = 0;
  final List<Widget> _children = [Pageone(), Pagetwo(), Pagethree()];
  @override
  Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         leading: Icon(CupertinoIcons.back),
//         middle: Text('iOS'),
//         trailing: Icon(CupertinoIcons.search),
//       ),
//       backgroundColor: CupertinoColors.white,
//       child: Text('data')
//     );
    return Scaffold(
      body: _children[_index],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _index,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(title: Text('aaa'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('bbb'), icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              title: Text('ccc'), icon: Icon(Icons.message)),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}

// class BottomBarApp extends StatefulWidget {
//   @override
//   _BottomBarAppState createState() => _BottomBarAppState();
// }

// class _BottomBarAppState extends State<BottomBarApp> {
//   int _index = 0;
//   final List<Widget> _children = [Pageone(), Pagetwo(), Pagethree()];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _children[_index],
//       bottomNavigationBar: CupertinoTabBar(
//         currentIndex: _index,
//         onTap: onTabTapped,
//         items: [
//           BottomNavigationBarItem(title: Text('aaa'), icon: Icon(Icons.home)),
//           BottomNavigationBarItem(title: Text('bbb'), icon: Icon(Icons.list)),
//           BottomNavigationBarItem(
//               title: Text('ccc'), icon: Icon(Icons.message)),
//         ],
//       ),
//     );
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _index = index;
//     });
//   }
// }


// 子页面
// class Pageone extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         leading: Icon(CupertinoIcons.back),
//         middle: Text('iOS'),
//         trailing: Icon(CupertinoIcons.search),
//       ),
//       backgroundColor: CupertinoColors.white,
//       child: Text('data')
//     );
//   }
// }

// class Pagetwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         leading: Icon(CupertinoIcons.back),
//         middle: Text('iOS'),
//         trailing: Icon(CupertinoIcons.search),
//       ),
//       backgroundColor: CupertinoColors.white,
//       child: Text('data')
//     );
//   }
// }

// class Pagethree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         leading: Icon(CupertinoIcons.back),
//         middle: Text('iOS'),
//         trailing: Icon(CupertinoIcons.search),
//       ),
//       backgroundColor: CupertinoColors.white,
//       child: Text('data')
//     );
//   }
// }
