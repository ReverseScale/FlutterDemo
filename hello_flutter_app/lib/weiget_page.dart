import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Weigets/text_page.dart';
import 'Weigets/list_page.dart';
import 'Weigets/image_page.dart';
import 'Weigets/color_page.dart';
import 'Weigets/navigation_page.dart';
import 'Weigets/tabBar_page.dart';
import 'Weigets/search_page.dart';
import 'Weigets/bethelPage_page.dart';
import 'Weigets/fuzzy_page.dart';
import 'Weigets/touch_page.dart';
import 'Weigets/animation_page.dart';

class WeigetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stack = Stack(
      alignment: const FractionalOffset(0.5, 0.9),
      children: <Widget>[
        ClipOval(
          child: FadeInImage.assetNetwork(
            placeholder: "",
            fit: BoxFit.cover,
            image:
                "https://avatars2.githubusercontent.com/u/13606492?s=460&v=4",
            width: 90.0,
            height: 90.0,
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Widget',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     children: <Widget>[
        //       stack,
        //       ListTile(
        //         title: Text("Github"),
        //         trailing: Icon(Icons.code),
        //         onTap: () {
        //           Navigator.of(context).pop();
        //           Navigator.of(context).push(new MaterialPageRoute(
        //               builder: (BuildContext context) => SettingsPage()));
        //         },
        //       ),
        //       Divider(),
        //       ListTile(
        //         title: Text("Blog"),
        //         trailing: Icon(Icons.web),
        //         onTap: () {
        //           Navigator.of(context).pop();
        //           Navigator.of(context).push(new MaterialPageRoute(
        //               builder: (BuildContext context) => SettingsPage()));
        //         },
        //       ),
        //       Divider(),
        //       ListTile(
        //         title: Text("About"),
        //         trailing: Icon(Icons.info),
        //         onTap: () {
        //           Navigator.of(context).pop();
        //           Navigator.of(context).push(MaterialPageRoute(
        //               builder: (BuildContext context) => SettingsPage()));
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: Container(
          color: Colors.grey[100],
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1.0,
            ),
            children: <Widget>[
              weigetCard(Icon(Icons.text_fields), "Text", context),
              weigetCard(Icon(Icons.format_list_bulleted), "List", context),
              weigetCard(Icon(Icons.image), "Image", context),
              weigetCard(Icon(Icons.color_lens), "Colors", context),
              weigetCard(Icon(Icons.navigation), "Navigation", context),
              weigetCard(Icon(Icons.tab), "Tabbar", context),
              weigetCard(Icon(Icons.search), "Search", context),
              weigetCard(Icon(Icons.vibration), "Animation", context),
              weigetCard(Icon(Icons.border_style), "Bethel", context),
              weigetCard(Icon(Icons.flip), "Fuzzy", context),
              weigetCard(Icon(Icons.touch_app), "Touch", context),
            ],
          ),
        ));
  }

  Widget weigetCard(Icon icon, String title, BuildContext context) =>
      GestureDetector(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: icon,
                ),
                Expanded(
                  child: Text(title),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          print(title);
          switch (title) {
            case "Text":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TextPage()));
              break;

            case "List":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListPage()));
              break;

            case "Image":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ImagePage()));
              break;

            case "Colors":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ColorsPage()));
              break;

            case "Navigation":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NavigationPage()));
              break;

            case "Tabbar":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TabBarPage()));
              break;

            case "Search":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SearchPage()));
              break;

            case "Bethel":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BethelPage()));
              break;

            case "Fuzzy":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FuzzyPage()));
              break;

            case "Touch":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TouchPage()));
              break;

            case "Animation":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AnimationsPage()));
              break;

            default:
          }
        },
      );
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情页')),
      body: Center(),
    );
  }
}
