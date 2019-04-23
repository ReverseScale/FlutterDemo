import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:device_info/device_info.dart';
import 'package:connectivity/connectivity.dart';

const String beeUri =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

class VideoDemo extends StatefulWidget {
  const VideoDemo({Key key}) : super(key: key);

  static const String routeName = '/video';

  @override
  _VideoDemoState createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final VideoPlayerController beeController = VideoPlayerController.network(beeUri);
  final VideoPlayerController butterflyController = VideoPlayerController.asset(
    'videos/butterfly.mp4',
    package: 'flutter_gallery_assets',
  );
  final Completer<void> connectedCompleter = Completer();

  bool isSupported = true;
  
  @override
  void initState() {
    super.initState();
    Future<void> initController(VideoPlayerController controller) async {
      controller.setLooping(true);
      controller.setVolume(0.0);
      controller.play();
      await connectedCompleter.future;
      await controller.initialize();
      if (mounted)
        setState(() {});
    }

    initController(butterflyController);
    initController(beeController);
    isIOSSimulator().then((bool ret) {
      isSupported = !ret;
    });
  }

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<bool> isIOSSimulator() async {
    return Platform.isIOS && !(await deviceInfoPlugin.iosInfo).isPhysicalDevice;
  }

  @override
  void dispose() {
    butterflyController.dispose();
    beeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: !isSupported ? Center(child: Text('Video playback not supported on the iOS Simulator.'),)
        : ConnectivityOverlay(
            child: ListView(
              children: <Widget>[
                VideoCard(
                  title: 'Butteryfly',
                  subtitle: '... flutters by',
                  controller: butterflyController,
                ),
                VideoCard(
                  title: 'Bee',
                  subtitle: '... gently buzzing',
                  controller: beeController,
                )
              ],
            ),
            connectedCompleter: connectedCompleter,
            scaffoldKey: scaffoldKey,
          ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({Key key, this.controller, this.title, this.subtitle})
      : super(key: key);

  final VideoPlayerController controller;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(title: Text(title), subtitle: Text(subtitle),),
            GestureDetector(
              onTap: (){
                final TransitionRoute<void> route = PageRouteBuilder(
                  settings: RouteSettings(name: title, isInitialRoute: false),
                  pageBuilder: (context, anim, secondary) => _buildFullScreenVideo()
                );
                route.completed.then((_) => controller.setVolume(0.0));
                controller.setVolume(1.0);
                Navigator.of(context).push(route);
              },
              child: _buildInlineVideo(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInlineVideo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Hero(tag: controller, child: VideoPlayerLoading(controller)),
      ),
    );
  }

  Widget _buildFullScreenVideo() {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: AspectRatio(aspectRatio: 3/2,
          child: Hero(tag: controller, child: VideoPlayPause(controller)),
        ),
      ),
    );
  }
}

class VideoPlayPause extends StatefulWidget {
  const VideoPlayPause(this.controller);

  final VideoPlayerController controller;

  @override
  State createState() => _VideoPlayPauseState();
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  VoidCallback listener;
  FadeAnimation imageFadeAnimation;

  _VideoPlayPauseState() {
    listener = (){
      if (mounted)
        setState(() {});
    };
  }

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          child: VideoPlayerLoading(controller),
          onTap: (){
            if (!controller.value.initialized)
              return;
            if (controller.value.isPlaying) {
              imageFadeAnimation = FadeAnimation(child: Icon(Icons.pause, size: 100.0,));
              controller.pause();
            } else {
              imageFadeAnimation = FadeAnimation(child: Icon(Icons.play_arrow, size: 100.0,));
              controller.play();
            }
          },
        ),
        Center(child: imageFadeAnimation,)
      ],
    );
  }
}

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);
    animationController.addListener((){
      if (mounted)
        setState(() {});
    });
    animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child)
      animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating ? Opacity(opacity: 1.0 - animationController.value, child: widget.child,)
      : Container();
  }
}

class VideoPlayerLoading extends StatefulWidget {
  const VideoPlayerLoading(this.controller);

  final VideoPlayerController controller;

  @override
  _VideoPlayerLoadingState createState() => _VideoPlayerLoadingState();
}

class _VideoPlayerLoadingState extends State<VideoPlayerLoading> {
  bool _initialized;

  @override
  void initState() {
    super.initState();
    _initialized = widget.controller.value.initialized;
    widget.controller.addListener((){
      if (!mounted)
        return;
      final bool initialized = widget.controller.value.initialized;
      if (_initialized != initialized)
        print('initialized=$initialized');
        setState(() {
          _initialized = initialized;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized)
      return VideoPlayer(widget.controller);
    return Stack(
      children: <Widget>[
        VideoPlayer(widget.controller),
        Center(child: CircularProgressIndicator())
      ],
    );
  }
}

class ConnectivityOverlay extends StatefulWidget {
  const ConnectivityOverlay({
    this.child,
    this.connectedCompleter,
    this.scaffoldKey,
  });

  final Widget child;
  final Completer<void> connectedCompleter;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _ConnectivityOverlayState createState() => _ConnectivityOverlayState();
}

class _ConnectivityOverlayState extends State<ConnectivityOverlay> {
  StreamSubscription<ConnectivityResult> connectSubscription;
  bool connected = true;

  static const Widget errorSnackBar = SnackBar(content: ListTile(
    title: Text('No network'),
    subtitle: Text('To load the videos you must have an active network connection'),
  ), backgroundColor: Colors.red,);

  @override
  void initState() {
    super.initState();

    Stream<ConnectivityResult> connectStream() async* {
      final Connectivity connectivity = Connectivity();
      ConnectivityResult preResult = await connectivity.checkConnectivity();
      print('preResult=$preResult');
      yield preResult;
      await for (ConnectivityResult result in connectivity.onConnectivityChanged) {
        print('result=$result');
        if (preResult != result) {
          yield result;
          preResult = result;
        }
      }
    }

    connectSubscription = connectStream().listen((ConnectivityResult ret) {
      if (!mounted)
        return;
      print('listen=$ret');
      if (ret == ConnectivityResult.none)
        widget.scaffoldKey.currentState.showSnackBar(errorSnackBar);
      else if (!widget.connectedCompleter.isCompleted)
        widget.connectedCompleter.complete(null);
    });
  }

  @override
  void dispose() {
    connectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}