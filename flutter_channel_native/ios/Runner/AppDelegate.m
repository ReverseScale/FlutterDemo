#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

#import <Flutter/Flutter.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"samples.flutter.io/battery"
                                            binaryMessenger:controller];
    
    
    // MethodChannel
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"getBatteryLevel" isEqualToString:call.method]) {
            int batteryLevel = [self getBatteryLevel];
            
            if (batteryLevel == -1) {

                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                           message:@"Battery info unavailable"
                                           details:nil]);
            } else {
                result(@(batteryLevel));
            }
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    FlutterEventChannel* eventChannel = [FlutterEventChannel eventChannelWithName:@"samples.flutter.io/test" binaryMessenger:controller];
    [eventChannel setStreamHandler:self];
    
    // 初始化定义
    FlutterBasicMessageChannel* messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"samples.flutter.io/message" binaryMessenger:controller];
    
    // 接收消息监听
    [messageChannel setMessageHandler:^(id message, FlutterReply callback) {
        NSLog(@"iOS：%@", message);
        callback(@"iOS：返回flutter端的数据");
    }];

  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// 获取电量方法
- (int)getBatteryLevel {
    UIDevice* device = UIDevice.currentDevice;
    device.batteryMonitoringEnabled = YES;
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterBasicMessageChannel* messageChannel2 = [FlutterBasicMessageChannel messageChannelWithName:@"samples.flutter.io/message2" binaryMessenger:controller];
    
    // 发送消息
    [messageChannel2 sendMessage:(@"iOS：发送给flutter的数据") reply:^(id reply) {
        NSLog(@"iOS：%@", reply);
    }];
    
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return -1;
    } else {
        return (int)(device.batteryLevel * 100);
    }
}

FlutterEventSink eventSink;
// 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    eventSink = events;
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        events(@"iOS：主动发送通知到flutter");
    }

    // 监听电池状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(onBatteryStateDidChange:)
                                               name:UIDeviceBatteryStateDidChangeNotification
                                             object:nil];
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    eventSink = nil;
    return nil;
}

- (void)onBatteryStateDidChange:(NSNotification*)notification {
    if (eventSink == nil) return;
    UIDeviceBatteryState state = [[UIDevice currentDevice] batteryState];
    switch (state) {
            case UIDeviceBatteryStateFull:
            case UIDeviceBatteryStateCharging:
            eventSink(@"iOS：charging");
            break;
            case UIDeviceBatteryStateUnplugged:
            eventSink(@"iOS：discharging");
            break;
        default:
            eventSink([FlutterError errorWithCode:@"UNAVAILABLE"
                                           message:@"Charging status unavailable"
                                           details:nil]);
            break;
    }
}

@end
