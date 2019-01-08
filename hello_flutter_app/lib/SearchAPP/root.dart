import 'package:flutter/material.dart';
import 'asset.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search',
      theme: ThemeData.light(),
      home: SearchHome(),
    );
  }
}

class SearchHome extends StatefulWidget {
  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Bar'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('想搜啥');
              showSearch(context: context, delegate: searchBarDelegate());
            },
          ),
        ],
      ),
    );
  }
}

class searchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
            title: RichText(
              text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
          ),
    );
  }
}
