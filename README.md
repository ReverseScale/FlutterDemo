# FlutterDemo
Flutter 练习存档
* 基础组件 -> hello_flutter_app
* 网络三方库封装 -> network_app
* iOS 已有项目 cocoapods 引入 Flutter -> network_app

### 下载 Flutter

推荐去官网下载，速度并不慢，网址：

https://flutter.io/setup-macos/

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-12/51698739.jpg)

或者也可以通过 git 将 Flutter 项目克隆到本地，其实和官网下载是一样滴。

```
git clone -b alpha https://github.com/flutter/flutter.git
```

### 配置环境变量

下载或者克隆完成后，到 flutter 所在目录，配置环境变量。

如果 bash_profile 文件不存在，就新建一下。

```
source ~/.bash_profile
```

开始配置环境变量

```
vim ~/.bash_profile
```

选择 edit，按键盘上的 “i” 键，进入可编辑状态，在文本中增加这三行（后面两行用于 flutter doctor 在天朝下载配置包）:

```
export PATH=/flutter/bin:$PATH
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

编辑完，按 “esc” 退出编辑状态，输入

```
:wq
```


保存一下，最后会出现 Welcom to Flutter!。

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-12/69737101.jpg)

设置 flutter 为全局可执行

```
export PATH="$PWD/flutter/bin:$PATH"
```

### 使用 flutter doctor 命令进行安装

运行 doctor 安装 Dart SDK 和工具包
```
flutter doctor
```

输出如下：

```
Downloading Dart SDK from Flutter engine e3687f70c7ece72000b32ee1b3c02755ba5361ac...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 87.9M  100 87.9M    0     0  4247k      0  0:00:21  0:00:21 --:--:-- 4945k

Downloading Material fonts...                                0.6s
Downloading package sky_engine...                            0.3s
Downloading common tools...                                  0.8s
Downloading darwin-x64 tools...                              3.4s
Downloading android-arm-profile/darwin-x64 tools...          0.6s
Downloading android-arm-release/darwin-x64 tools...          0.7s
Downloading android-arm64-profile/darwin-x64 tools...        0.6s
Downloading android-arm64-release/darwin-x64 tools...        0.6s
Downloading android-x86 tools...                             1.9s
Downloading android-x64 tools...                             2.4s
Downloading android-arm tools...                             1.2s
Downloading android-arm-profile tools...                     0.9s
Downloading android-arm-release tools...                     0.7s
Downloading android-arm64 tools...                           1.1s
Downloading android-arm64-profile tools...                   1.0s
Downloading android-arm64-release tools...                   0.8s
Downloading ios tools...                                     4.3s
Downloading ios-profile tools...                             3.7s
Downloading ios-release tools...                             3.2s
Downloading Gradle Wrapper...                                0.1s
```

### Android Studio 
官方地址：https://developer.android.com/studio/

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-12/75268045.jpg)

相关依赖配置可以在 AndroidDevtools 网站找，基本都有的。
AndroidDevtools：http://www.androiddevtools.cn

#### 解决 gradle sync 太慢的问题

就算是翻了墙，gradle sync 依然速度感人，而且国内访问jcenter太慢（甚至连接不上），就会报各种关于依赖更新失败的错误。
 
以前oschina（也就是开源中国）提供了jcenter的镜像地址，然而不幸的是因为各种原因，最近停止服务了
开源中国 Maven 镜像库关闭访问
 
幸运的是阿里云提供了jcenter镜像  http://maven.aliyun.com/
 
可以在工程gradle中如下修改，加速 gradle sync

```
// Top-level build file where you can add configuration options common to all sub-projects/modules.  
  
buildscript {  
    repositories {  
        maven{ url 'http://maven.aliyun.com/nexus/content/groups/public'}  
        //jcenter()  
    }  
    dependencies {  
        classpath 'com.android.tools.build:gradle:2.2.2'  
  
        // NOTE: Do not place your application dependencies here; they belong  
        // in the individual module build.gradle files  
    }  
}  
  
allprojects {  
    repositories {  
        maven{ url 'http://maven.aliyun.com/nexus/content/groups/public'}  
        //jcenter()  
    }  
}  
```

### Xcode
Xcode 需要 macOS 系统的支持，如果用的是 MacBook，打开 App Store 直接下载就好了。

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-12/30400168.jpg)

### Visual Studio Code
虽然 Android Studio 也可以用，但是 VS Code 更加轻量，所以推荐一下。

官网：https://code.visualstudio.com
![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-14/15588749.jpg)

安装 Flutter 包，就可以愉快的敲代码了..
![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-14/12814682.jpg)

而且可以直接选择运行的虚拟机，从此不需要打开繁重的双端IDE。

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-14/90348166.jpg)


### Flutter Demo 

简单的 Demo，用 Flutter 写的可以展示豆瓣 Top250 电影的 Demo：https://github.com/ReverseScale/flutter-demo-topmovies

运行结果如下：

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-12/60222818.jpg)


### 使用三方库

Flutter 项目中通过 `pubspec.yaml` 来管理第三方库，在 `pubspec.yaml` 中添加第三方库名称和版本号等信息。

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-14/29216368.jpg)

以引入 dio 为例

```
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2
  dio: ^1.0.9
```

加入一行
```
dio: x.x.x  #latest version
```

并执行`flutter packages get`即可将三方库拉入本地工程文件。

```
flutter packages get
```

### cocoapods 引入

完成引入后的目录结构如下：
![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-14/66336862.jpg)

* FlutterDemo: 总的父目录
* FlutterIOS: iOS 已有的项目工程
* flutter_module: Flutter 的库包

#### 创建 module 包
到 cd 到总目录 FlutterDemo 下，执行 Flutter 命令 `flutter create -t module xxx`：

```
flutter create -t module flutter_module
```

运行过后，目录中就出现了 flutter_module 文件。

#### Pods 绑定

这里只介绍通过 cocoapods 绑定 module 包方法，手动导入请参考 Flutter Github wiki。

打开 `Podfile` 添加如下内容：

```
flutter_application_path = '/Users/whatsxie/Desktop/FlutterDemo/flutter_module/'
  eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)
```

> 注：上面的路径需要根据本地位置修改

执行 `pod install` 即可完成绑定。

#### 设置脚本

打开 Xcode 至项目 TARGETS - 项目名 - BuildPhases 下，添加一个执行脚本。

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-14/53269185.jpg)

运行 `⌘B` 绑定库就 OK 了。


#### Native 调用 Flutter 视图

Demo 中是 Swift 实现，网上很多 OC 的实现，这里两种语言都提供参考。
OC:
AppDelegate.h
```
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

@interface AppDelegate : FlutterAppDelegate
@end
```

AppDelegate.m
```
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h> // Only if you have Flutter Plugins

#include "AppDelegate.h"

@implementation AppDelegate

// This override can be omitted if you do not have any Flutter Plugins.
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```

ViewController.m
```
#import <Flutter/Flutter.h>
#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)handleButtonAction {
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] init];
    [self presentViewController:flutterViewController animated:false completion:nil];
}
@end
```


Swift:
AppDelegate.swift
```
import UIKit
import Flutter
import FlutterPluginRegistrant // Only if you have Flutter Plugins.

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {

  // Only if you have Flutter plugins.
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    GeneratedPluginRegistrant.register(with: self);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }

}
```

ViewController.swift
```
import UIKit
import Flutter

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let button = UIButton(type:UIButtonType.custom)
    button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
    button.setTitle("Press me", for: UIControlState.normal)
    button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
    button.backgroundColor = UIColor.blue
    self.view.addSubview(button)
  }

  @objc func handleButtonAction() {
    let flutterViewController = FlutterViewController()
    self.present(flutterViewController, animated: false, completion: nil)
  }
}
```

具体使用中的 Route 跳转方式

OC:
```
[flutterViewController setInitialRoute:@"route1"];
```

Swift:
```
flutterViewController.setInitialRoute("route1")
```


### 相关链接：

Flutter 中国：https://flutter.io/community/china

Flutter 中文社区：
https://flutter-io.cn/

Flutter Github Wiki:
https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#experiment-integrate-flutterviewcontroller

