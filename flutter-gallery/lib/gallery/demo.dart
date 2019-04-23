import 'package:flutter/material.dart';
import 'package:gallery/demo/material/buttons_demo.dart';
import 'package:gallery/gallery/demos.dart';
import 'package:url_launcher/url_launcher.dart';


class MaterialDemoDocumentationButton extends StatelessWidget {
  MaterialDemoDocumentationButton(String routeName, { Key key })
    : documentationUrl = demoDocumentationUrl[routeName],
      assert(demoDocumentationUrl[routeName] != null,
      'A documentation URL was not specified for demo route $routeName in kAllGalleryDemos',
      ),
      super(key: key);

  final String documentationUrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.library_books),
      tooltip: 'API documentation',
      onPressed: ()=>launch(documentationUrl,forceWebView: true),
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
  bool operator==(Object other) {
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
          actions: (actions ?? [])..addAll([
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.library_books, semanticLabel: 'Show documentation',),
                onPressed: ()=>_showApiDocumentation(context),
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.code),
                tooltip: 'Show example code',
                onPressed: ()=>_showExampleCode(context),
              ),
            )
          ]),
          bottom: TabBar(isScrollable: true,tabs: demos.map((ComponentDemoTabData data) => Tab(
            text: data.tabName,
          )).toList()),
        ),
        body: TabBarView(
          children: demos.map((ComponentDemoTabData data) => SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(data.description, style: Theme.of(context).textTheme.subhead,),
                ),
                Expanded(child: data.demoWidget)
              ],
            ),
          )).toList()),
      ),
    );
  }

  void _showApiDocumentation(BuildContext context) {
    final String url = demos[DefaultTabController.of(context).index].documentationUrl;
//    print('url=$url');
    if (url != null)
      launch(url, forceWebView: true);
  }

  void _showExampleCode(BuildContext context) {
    final String tag = demos[DefaultTabController
        .of(context)
        .index].exampleCodeTag;
    if (tag != null)
      Navigator.push(context, MaterialPageRoute(builder: (context2) => FullScreenCodeDialog(exampleCodeTag: tag,)));
  }
}