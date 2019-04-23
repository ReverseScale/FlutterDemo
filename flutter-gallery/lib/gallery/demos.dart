import 'package:flutter/material.dart';
import 'package:gallery/demo/animation_demo.dart';
import 'package:gallery/demo/backdrop_demo.dart';
import 'package:gallery/demo/colors_demo.dart';
import 'package:gallery/demo/contracts_demo.dart';
import 'package:gallery/demo/images_demo.dart';
import 'package:gallery/demo/material/bottom_app_bar_demo.dart';
import 'package:gallery/demo/material/bottom_navigation_demo.dart';
import 'package:gallery/demo/material/buttons_demo.dart';
import 'package:gallery/demo/material/cards_demo.dart';
import 'package:gallery/demo/material/chip_demo.dart';
import 'package:gallery/demo/material/data_table_demo.dart';
import 'package:gallery/demo/material/modal_bottom_sheet_demo.dart';
import 'package:gallery/demo/material/persistent_bottom_sheet_demo.dart';
import 'package:gallery/demo/material/tabs_fab_demo.dart';
import 'package:gallery/demo/pesto_demo.dart';
import 'package:gallery/demo/shrine_demo.dart';
import 'package:gallery/demo/typo_graphy_demo.dart';
import 'package:gallery/demo/video_demo.dart';
import 'package:gallery/gallery/icons.dart';

class GalleryDemoCategory {
  const GalleryDemoCategory._({ this.name, this.icon });

  @required final String name;
  @required final IconData icon;

  @override
  bool operator ==(other) {
    if (identical(this, other))
      return true;
    if (runtimeType != other.runtimeType)
      return false;

    final GalleryDemoCategory typedOther = other;
    return typedOther.name == name && typedOther.icon == icon;
  }

  @override
  int get hashCode => hashValues(name, icon);

  @override
  String toString() {
    return '$runtimeType($name)';
  }
}

const GalleryDemoCategory _demos = GalleryDemoCategory._(
  name: 'Studies',
  icon: GalleryIcons.animation,
);

const GalleryDemoCategory _style = GalleryDemoCategory._(
  name: 'Style',
  icon: GalleryIcons.custom_typography,
);

const GalleryDemoCategory _materialComponents = GalleryDemoCategory._(
  name: 'Material',
  icon: GalleryIcons.category_mdc,
);

const GalleryDemoCategory _cupertinoComponents = GalleryDemoCategory._(
  name: 'Cupertino',
  icon: GalleryIcons.phone_iphone,
);

const GalleryDemoCategory _media = GalleryDemoCategory._(
  name: 'Media',
  icon: GalleryIcons.drive_video,
);

class GalleryDemo {
  const GalleryDemo({
    @required this.title,
    @required this.icon,
    this.subtitle,
    @required this.category,
    @required this.routeName,
    this.documentationUrl,
    @required this.buildRoute,
  })
      : assert(title != null),
        assert(category != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String title;
  final IconData icon;
  final String subtitle;
  final GalleryDemoCategory category;
  final String routeName;
  final WidgetBuilder buildRoute;
  final String documentationUrl;

  @override
  String toString() {
    return '$runtimeType($title $routeName)';
  }
}

List<GalleryDemo> _buildGalleryDemos() {
  final List<GalleryDemo> galleryDemos = <GalleryDemo>[
    // Demos
    GalleryDemo(
      title: 'Shrine',
      subtitle: 'Basic shopping app',
      icon: GalleryIcons.shrine,
      category: _demos,
      routeName: ShrineDemo.routeName,
      buildRoute: (BuildContext context) => ShrineDemo(),
    ),
    GalleryDemo(
      title: 'Contact profile',
      subtitle: 'Address book entry with a flexible appbar',
      icon: GalleryIcons.account_box,
      category: _demos,
      routeName: ContactsDemo.routeName,
      buildRoute: (BuildContext context) => ContactsDemo(),
    ),
    GalleryDemo(
      title: 'Animation',
      subtitle: 'Section organizer',
      icon: GalleryIcons.animation,
      category: _demos,
      routeName: AnimationDemo.routeName,
      buildRoute: (BuildContext context) => AnimationDemo(),
    ),
    // Style
    GalleryDemo(
      title: 'Colors',
      subtitle: 'All of the predefined colors',
      icon: GalleryIcons.colors,
      category: _style,
      routeName: ColorsDemo.routeName,
      buildRoute: (BuildContext context) => ColorsDemo(),
    ),
    GalleryDemo(
      title: 'Typography',
      subtitle: 'All of the predefined text styles',
      icon: GalleryIcons.custom_typography,
      category: _style,
      routeName: TypographyDemo.routeName,
      buildRoute: (BuildContext context) => TypographyDemo(),
    ),

    // Material Components
    GalleryDemo(
      title: 'Backdrop',
      subtitle: 'Select a front layer from back layer',
      icon: GalleryIcons.backdrop,
      category: _materialComponents,
      routeName: BackdropDemo.routeName,
      buildRoute: (BuildContext context) => BackdropDemo(),
    ),
    GalleryDemo(
      title: 'Bottom app bar',
      subtitle: 'Optional floating action button notch',
      icon: GalleryIcons.bottom_app_bar,
      category: _materialComponents,
      routeName: BottomAppBarDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/BottomAppBar-class.html',
      buildRoute: (BuildContext context) => BottomAppBarDemo(),
    ),
    GalleryDemo(
      title: 'Bottom navigation',
      subtitle: 'Bottom navigation with cross-fading views',
      icon: GalleryIcons.bottom_navigation,
      category: _materialComponents,
      routeName: BottomNavigationDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html',
      buildRoute: (BuildContext context) => BottomNavigationDemo(),
    ),
    GalleryDemo(
      title: 'Bottom sheet: Modal',
      subtitle: 'A dismissable bottom sheet',
      icon: GalleryIcons.bottom_sheets,
      category: _materialComponents,
      routeName: ModalBottomSheetDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/showModalBottomSheet.html',
      buildRoute: (BuildContext context) => ModalBottomSheetDemo(),
    ),
    GalleryDemo(
      title: 'Bottom sheet: Persistent',
      subtitle: 'A bottom sheet that sticks around',
      icon: GalleryIcons.bottom_sheet_persistent,
      category: _materialComponents,
      routeName: PersistentBottomSheetDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/ScaffoldState/showBottomSheet.html',
      buildRoute: (BuildContext context) => PersistentBottomSheetDemo(),
    ),
    GalleryDemo(
      title: 'Buttons',
      subtitle: 'Flat, raised, dropdown, and more',
      icon: GalleryIcons.generic_buttons,
      category: _materialComponents,
      routeName: ButtonsDemo.routeName,
      buildRoute: (BuildContext context) => ButtonsDemo(),
    ),
    GalleryDemo(
      title: 'Buttons: Floating Action Button',
      subtitle: 'FAB with transitions',
      icon: GalleryIcons.buttons,
      category: _materialComponents,
      routeName: TabsFabDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/FloatingActionButton-class.html',
      buildRoute: (BuildContext context) => TabsFabDemo(),
    ),
    GalleryDemo(
      title: 'Cards',
      subtitle: 'Baseline cards with rounded corners',
      icon: GalleryIcons.cards,
      category: _materialComponents,
      routeName: CardsDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/Card-class.html',
      buildRoute: (BuildContext context) => CardsDemo(),
    ),
    GalleryDemo(
      title: 'Chips',
      subtitle: 'Labeled with delete buttons and avatars',
      icon: GalleryIcons.chips,
      category: _materialComponents,
      routeName: ChipDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/Chip-class.html',
      buildRoute: (BuildContext context) => ChipDemo(),
    ),
    GalleryDemo(
      title: 'Data tables',
      subtitle: 'Rows and columns',
      icon: GalleryIcons.data_table,
      category: _materialComponents,
      routeName: DataTableDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/PaginatedDataTable-class.html',
      buildRoute: (BuildContext context) => DataTableDemo(),
    ),
    GalleryDemo(
      title: 'Animated images',
      subtitle: 'GIF and WebP animations',
      icon: GalleryIcons.animation,
      category: _media,
      routeName: ImagesDemo.routeName,
      buildRoute: (BuildContext context) => ImagesDemo(),
    ),
    GalleryDemo(
      title: 'Video',
      subtitle: 'Video playback',
      icon: GalleryIcons.drive_video,
      category: _media,
      routeName: VideoDemo.routeName,
      buildRoute: (BuildContext context) => const VideoDemo(),
    ),
  ];

  // Keep Pesto around for its regression test value. It is not included
  // in (release builds) the performance tests.
  assert(() {
    galleryDemos.insert(0,
      GalleryDemo(
        title: 'Pesto',
        subtitle: 'Simple recipe browser',
        icon: Icons.adjust,
        category: _demos,
        routeName: PestoDemo.routeName,
        buildRoute: (BuildContext context) => const PestoDemo(),
      ),
    );
    return true;
  }());

  return galleryDemos;
}

final List<GalleryDemo> allGalleryDemos = _buildGalleryDemos();

final Set<GalleryDemoCategory> allGalleryDemoCategories =
  allGalleryDemos.map((GalleryDemo demo) => demo.category).toSet();

final Map<GalleryDemoCategory, List<GalleryDemo>> galleryCategoryToDemos =
  Map<GalleryDemoCategory, List<GalleryDemo>>.fromIterable(
    allGalleryDemoCategories,
    value: (category) {
      return allGalleryDemos.where((GalleryDemo demo) => demo.category == category).toList();
    }
  );

final Map<String, String> demoDocumentationUrl =
  Map<String, String>.fromIterable(
    allGalleryDemos.where((GalleryDemo demo) => demo.documentationUrl != null),
    key: (demo) => demo.routeName,
    value: (demo) => demo.documentationUrl,
  );