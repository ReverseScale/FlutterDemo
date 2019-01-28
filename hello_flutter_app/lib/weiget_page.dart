import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Weigets/text_page.dart';
import 'Weigets/list_page.dart';
import 'Weigets/image_page.dart';
import 'Weigets/color_page.dart';
import 'Weigets/navigation_page.dart';
import 'Weigets/bottomBar_page.dart';

class WeigetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Widget',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
        ),
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
              weigetCard(Icon(Icons.chat), "Chat", context),
              weigetCard(Icon(Icons.search), "Search", context),
              weigetCard(Icon(Icons.data_usage), "Data base", context),
              weigetCard(Icon(Icons.vibration), "Animation", context),
              weigetCard(Icon(Icons.filter_b_and_w), "AD", context),
              weigetCard(Icon(Icons.border_style), "Bethel", context),
              weigetCard(Icon(Icons.flip), "Fuzzy", context),
              weigetCard(Icon(Icons.toc), "Drawer", context),
              weigetCard(Icon(Icons.phonelink_setup), "Push", context),
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
                  builder: (BuildContext context) => BottomBarPage()));
              break;

            default:
          }
        },
      );
}
