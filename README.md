# FlutterDemo
## 📇 内容大纲：
* 项目介绍
* 配置开发环境
* 安装开发工具
* Debug 技巧
* 三方库使用与发布
* iOS 混编开发（Swift、OC）
* Demo 演示

### 🗞 项目介绍

### 官方示例
目前来看最好的 Flutter 示例工程，功能完善、结构清晰。

工程路径：
```
/flutter_gallery
```

| 项目演示首页 | 项目菜单页面 | 项目成品展示 | 项目通讯录页 | 项目控件介绍 | 项目提示控件 |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| ![kezOnP.png](https://s2.ax1x.com/2019/01/25/kezOnP.png) | ![kezj78.png](https://s2.ax1x.com/2019/01/25/kezj78.png) | ![kmSShQ.png](https://s2.ax1x.com/2019/01/25/kmSShQ.png) | ![kmSC1s.png](https://s2.ax1x.com/2019/01/25/kmSC1s.png) | ![kmSZAU.png](https://s2.ax1x.com/2019/01/25/kmSZAU.png) | ![kmSK39.png](https://s2.ax1x.com/2019/01/25/kmSK39.png) |

Flutter 通过跨平台的 Skia 图形库来实现图形渲染，只依赖各个系统的图形绘制相关的 Api，所以借助 Hummingbird 可以实现桌面端的渲染工作。

![kmpJrq.png](https://s2.ax1x.com/2019/01/25/kmpJrq.png)

通过 Hummingbird 输出到 macOS 效果：

| 项目演示首页 | 项目菜单页面 | 项目成品展示 |
| ------------- | ------------- | ------------- |
| ![km9sfg.png](https://s2.ax1x.com/2019/01/25/km9sfg.png) | ![km9Dk8.png](https://s2.ax1x.com/2019/01/25/km9Dk8.png) | ![kmpTsI.png](https://s2.ax1x.com/2019/01/25/kmpTsI.png) | 


### iOS 原生项目混编
根据官方文档实现的原生 <-> Flutter 混编示例，Demo 工程使用 Swift 实现，文档部分有 OC、Swift 分别实现方法。

工程路径：
```
# Flutter 资源包
/FlutterDemo/flutter_module 

# iOS 原生工程
/FlutterDemo/FlutterIOS
```

> 运行前需要重新设定文件路径，否则 pod install 会报错。

### Flutter 控件练习
真正意义上的 Demo 工程，分别演示一些常用的功能控件使用和一些单页面（见底部效果图）。

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/19-1-10/43734919.jpg)

工程路径：
```
/hello_flutter_app
```

### Flutter 网络库使用
使用 dio + rxdart 实现优雅的网络数据请求。

工程路径：
```
/network_app
```

### Flutter 路由库使用
使用 fluro 实现灵活的路由管理。

工程路径：
```
/router_fluro
```

### Cupertino 风格示例
鉴于目前设计师的出稿风格都是 Apple Design，这里新增 Cupertino 风格示例工程。

工程路径：
```
/veggieseasons
```


█◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢█

## 🛠 配置开发环境
### 下载 Flutter

推荐去官网下载，速度并不慢，网址：https://flutter.io/setup-macos/

![](https://user-gold-cdn.xitu.io/2018/12/14/167aa27d47fa55f6?w=1582&h=414&f=png&s=63434)

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

![](https://user-gold-cdn.xitu.io/2018/12/14/167aa27d4d004fcf?w=1140&h=904&f=png&s=152641)

设置 flutter 为全局可执行

```
export PATH="$PWD/flutter/bin:$PATH"
```

### 使用 flutter doctor 命令进行安装检查

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

## 🔨 安装开发工具
### Android Studio 
官方地址：https://developer.android.com/studio/

![](https://user-gold-cdn.xitu.io/2018/12/14/167aa27d4ba21c87?w=1440&h=544&f=png&s=79024)

相关依赖配置可以在 AndroidDevtools 网站找，基本都有的。
AndroidDevtools：http://www.androiddevtools.cn

> 解决 gradle sync 太慢的问题

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

![](https://user-gold-cdn.xitu.io/2018/12/14/167aa27d4bbfbc14?w=2360&h=1448&f=png&s=2378266)

### Visual Studio Code
虽然 Android Studio 也可以用，但是 VS Code 更加轻量，所以推荐一下。

官网：https://code.visualstudio.com
![](https://user-gold-cdn.xitu.io/2018/12/14/167aabcc6f146584?w=2304&h=962&f=png&s=435208)

安装 Flutter 包，就可以愉快的敲代码了..
![](https://user-gold-cdn.xitu.io/2018/12/14/167aabcc6c67bd7d?w=714&h=564&f=jpeg&s=71952)

而且可以直接选择运行的虚拟机，从此不需要打开繁重的双端IDE。

![](https://user-gold-cdn.xitu.io/2018/12/14/167aabcc6ade980e?w=1300&h=274&f=png&s=26614)


## 🐛 Debug 技巧

这里以 VSCode 做为 Dart 编辑工具为例，演示一下常用的 Debug 技巧。

### 断点调试

和常用的 IDE 一样，在代码左侧点一下就会创建一个断点，在 VSCode 的 Debug 模式下点击 `run` 即可进行断点调试。

![](https://user-gold-cdn.xitu.io/2018/12/20/167c990b20cca7f1?w=974&h=148&f=png&s=32873)

### debugger 调试

当使用 Dart Observatory 时，可以使用debugger() 语句插入编程式断点,首先需要添加

```
import 'dart:developer';
```

然后在需要 debugger 的代码处添加方法即可。

```
void someFunction(double offset) {
  debugger(when: offset > 30.0, message: 'offset 大于 30 时，启动断点调试);
  // ...
}
```

除此之外，还可以通过 `print` `debugPrint` `flutter logs` 在系统控制台中打印信息辅助调试。

### 查看运行状态

当我们从命令行运行 `flutter run` 运行程序时，控制台会给我们一个站内链接，以便我们查看运行状态。

![](https://user-gold-cdn.xitu.io/2018/12/20/167c990b25562105?w=734&h=67&f=png&s=14037)

使用 Chrome 浏览器打开上图的链接，就可以看到具体的运行状态信息了。

![](https://user-gold-cdn.xitu.io/2018/12/20/167c990b26e7713c?w=1192&h=646&f=png&s=98449)

## 📦 三方库使用与发布
### 使用三方库

Flutter 项目中通过 `pubspec.yaml` 来管理第三方库，在 `pubspec.yaml` 中添加第三方库名称和版本号等信息。

![](https://user-gold-cdn.xitu.io/2018/12/14/167aabcc6f695ae0?w=596&h=244&f=png&s=26771)

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

### 发布三方库

上面通过 pubspec 管理的三方库大都也是开发者封装后打包发布的，接下来我们来试着发布一个自己的三方库。

package 分类：
* Dart packages：使用 Dart 语言编写，为 Flutter 做功能扩展的库。
* plugin packages：在 Dart packages 基础上，包含 iOS 和 Android 功能调用的插件包。

#### 创建 packages

dart package:
```
flutter create --template=package test_dart_package
```

plugin package:
```
flutter create --org com.rs.example --template=plugin -i swift -a kotlin test_flutter_package
```

参数说明：
* --org com.rs.example:包的组织名
* -i swift:包使用 Swift 
* -a kotlin:包使用 kotlin 支持 

工程目录说明：
* lib/test_flutter_package.dart:插件包的Dart API.
* android/src/main/java/com/yourcompany/test_flutter_package/TestFlutterPackagePlugin.kt:插件包API的Android实现.
* ios/Classes/TestFlutterPackagePlugin.m:插件包API的ios实现.
* example/:一个依赖于该插件的Flutter应用程序，来说明如何使用它

#### 发布 packages

运行 dry-run 命令以查看是否都准备OK了:
```
flutter packages pub publish --dry-run
```

运行发布命令:
```
flutter packages pub publish
```

更多请阅读 [Flutter 中文网](https://flutterchina.club/developing-packages/#step-1-开发dart包)

## 📱 iOS 混编开发（Swift、OC）
### Cocoapods 引入

完成引入后的目录结构如下：
![](https://user-gold-cdn.xitu.io/2018/12/14/167ab90307245012?w=816&h=80&f=jpeg&s=17111)

* FlutterDemo: 总的父目录
* FlutterIOS: iOS 已有的项目工程
* flutter_module: Flutter 的库包

### 创建 module 包
到 cd 到总目录 FlutterDemo 下，执行 Flutter 命令 `flutter create -t module xxx`：

```
flutter create -t module flutter_module
```

运行过后，目录中就出现了 flutter_module 文件。

### Pods 绑定

这里只介绍通过 cocoapods 绑定 module 包方法，手动导入请参考 Flutter Github wiki。

打开 `Podfile` 添加如下内容：

```
flutter_application_path = '/Users/whatsxie/Desktop/FlutterDemo/flutter_module/'
  eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)
```

> 注：上面的路径需要根据本地位置修改

运行 Demo 工程可能同时需要修改下图的路径：

![kezclR.png](https://s2.ax1x.com/2019/01/25/kezclR.png)

执行 `pod install` 即可完成绑定。

### 设置脚本

打开 Xcode 至项目 TARGETS - 项目名 - BuildPhases 下，添加一个执行脚本。

```
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" build
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" embed
```

![](https://user-gold-cdn.xitu.io/2018/12/14/167ab90308dc4167?w=1101&h=559&f=png&s=298040)

运行 `⌘B` 绑定库就 OK 了。


### Native 调用 Flutter 视图

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

更多 iOS 与 Flutter 的相互调用，参考 Github Demo 中的 FlutterDemo。


## 🎞 Demo 演示

1）Todolist UI

```
cd FlutterDemo/hello_flutter_app/lib/TodoPage.dart
```

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-29/53674347.jpg)

2）SQL数据库 通讯录

```
cd FlutterDemo/hello_flutter_app/lib/DataApp.dart
```

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-29/63192092.jpg)

3）旅游通信

```
cd FlutterDemo/hello_flutter_app/lib/ComplexApp.dart
cd FlutterDemo/hello_flutter_app/lib/ChatsApp.dart
```

![](http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-29/99893081.jpg)

## 📚 相关链接

* Flutter 中国：https://flutter.io/community/china
* Flutter 中文社区：
https://flutter-io.cn/
* Flutter Github Wiki:
https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#experiment-integrate-flutterviewcontroller

## 😬 联系

* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io

