import 'package:flutter/material.dart';
import 'package:gallery/gallery/demo.dart';

class ImagesDemo extends StatelessWidget {
  static const String routeName = '/images';

  @override
  Widget build(BuildContext context) {
    return TabbedComponentDemoScaffold(
      title: 'Animated images',
      demos: [
        ComponentDemoTabData(
          tabName: 'WEBP',
          description: 'WEBP',
          exampleCodeTag: 'animated_image',
          demoWidget: Image.asset(
            'animated_images/animated_flutter_stickers.webp',
            package: 'flutter_gallery_assets',
          )
        ),
        ComponentDemoTabData(
            tabName: 'GIF',
            description: 'GIF',
            exampleCodeTag: 'animated_image',
            demoWidget: Image.asset(
              'animated_images/animated_flutter_lgtm.gif',
              package: 'flutter_gallery_assets',
            )
        )
      ],
    );
  }
}