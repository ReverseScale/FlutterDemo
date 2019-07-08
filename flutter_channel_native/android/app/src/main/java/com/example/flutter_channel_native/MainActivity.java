package com.example.flutter_channel_native;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.widget.Toast;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "samples.flutter.io/battery";
  private static final String CHANNEL_MESSAGE = "samples.flutter.io/message";

  private MethodChannel mMethodChannel;
  private EventChannel.EventSink mEventSink;

  private static final String CHANNEL1 = "samples.flutter.io/battery";
  private static final String CHANNEL2 = "samples.flutter.io/test";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

      getBattery();

      getMessage();


      listenAlert();

      new MethodChannel(getFlutterView(), CHANNEL1).setMethodCallHandler(
              new MethodChannel.MethodCallHandler() {
                  @Override
                  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                      // TODO
                      if (call.method.equals("getBatteryLevelBase")) {
                          int batteryLevel = getBatteryLevelBase();

                          if (batteryLevel != -1) {
                              result.success(batteryLevel);
                          } else {
                              result.error("UNAVAILABLE", "Battery level not available.", null);
                          }
                      } else {
                          result.notImplemented();
                      }
                  }
              }
      );

      new EventChannel(getFlutterView(), CHANNEL2).setStreamHandler(
              new EventChannel.StreamHandler() {
                  @Override
                  public void onListen(Object o, EventChannel.EventSink eventSink) {
                      this.eventSink = eventSink;

                      handler.sendEmptyMessageDelayed(1, 1000);
                  }

                  @Override
                  public void onCancel(Object o) {

                  }

                  private EventChannel.EventSink eventSink;
                  private int count = 0;
                  private Handler handler = new Handler() {
                      @Override
                      public void handleMessage(Message msg) {
                          super.handleMessage(msg);
                          eventSink.success((count++) + "主动发送消息给flutter");
//              handler.sendEmptyMessageDelayed(1,1000);
                      }
                  };

              }
      );

      BasicMessageChannel<Object> messageChannel = new BasicMessageChannel<Object>(getFlutterView(), "samples.flutter.io/message", StandardMessageCodec.INSTANCE);


      // 接收消息监听
      messageChannel.setMessageHandler(new BasicMessageChannel.MessageHandler<Object>() {
          @Override
          public void onMessage(Object o, BasicMessageChannel.Reply<Object> reply) {
              System.out.println("onMessage: " + o);
              reply.reply("返回给flutter的数据");
          }
      });
  }

    @Override
    protected void onResume() {
        super.onResume();
        Map map = new HashMap<>();
        map.put("content", "Android Message");
        mMethodChannel.invokeMethod("showText", map, new MethodChannel.Result() {
            @Override
            public void success(Object o) {
                Log.d("MainActivity", (String) o);
            }

            @Override
            public void error(String s, String s1, Object o) {
                Log.d("MainActivity", "errorCode: " + s + " errorMessage: " + s1 + " errorDetail: " + o);
            }

            @Override
            public void notImplemented() {
                Log.d("MainActivity", "notImplemented");
            }
        });

        if (mEventSink != null) {
            mEventSink.success("Android Message too");
        }
    }

  private void listenAlert() {

      mMethodChannel = new MethodChannel(getFlutterView(), "samples.flutter.io/toast");

      new EventChannel(getFlutterView(), "samples.flutter.io/event").setStreamHandler(new EventChannel.StreamHandler() {
          @Override
          public void onListen(Object o, EventChannel.EventSink sink) {
              mEventSink = sink;
          }

          @Override
          public void onCancel(Object o) {
              mEventSink = null;
          }
      });

      new MethodChannel(getFlutterView(), "samples.flutter.io/toast").setMethodCallHandler((call, result) -> {
          if ("toast".equals(call.method)) {
              if (call.hasArgument("content")) {
                  Toast.makeText(getBaseContext(), call.argument("content"), Toast.LENGTH_SHORT).show();
                  result.success("success");
              } else {
                  result.error("-1", "toast fail", "content is null");
              }
          } else {
              result.notImplemented();
          }
      });
  }


  private void getMessage() {
      new MethodChannel(getFlutterView(), CHANNEL_MESSAGE).setMethodCallHandler(
              new MethodChannel.MethodCallHandler() {
                  @Override
                  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                      if (call.method.equals("getMessage")) {
                          result.success("Message: Hi");
                      } else {
                          result.notImplemented();
                      }
                  }
              });
    }

  private void getBattery() {
      new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
              new MethodChannel.MethodCallHandler() {
                  @Override
                  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                      if (call.method.equals("getBatteryLevel")) {
                          int batteryLevel = getBatteryLevel();

                          if (batteryLevel != -1) {
                              result.success(batteryLevel);
                          } else {
                              result.error("UNAVAILABLE", "Battery level not available.", null);
                          }
                      } else if (call.method.equals("getMessage")) {
                          openGooglePlay();
                          result.success("Message: Hi");
                      } else {
                          result.notImplemented();
                      }
                  }
              });
  }


  private void openGooglePlay() {
//    MarketUtil.toMarket(this, APP_PACKAGE, null);

    System.out.println(MarketUtil.queryInstalledMarketPkgs(this));

    MarketUtil.filterInstalledPkgs(this, MarketUtil.queryInstalledMarketPkgs(this));

    System.out.println(MarketUtil.filterInstalledPkgs(this, MarketUtil.queryInstalledMarketPkgs(this)));

    GeneratedPluginRegistrant.registerWith(this);
  }

  private int getBatteryLevel() {
    int batteryLevel = -1;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).
              registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
              intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }

    return batteryLevel;
  }

    private int getBatteryLevelBase() {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        BasicMessageChannel<Object> messageChannel2 = new BasicMessageChannel<Object>(getFlutterView(), "samples.flutter.io/message2", StandardMessageCodec.INSTANCE);

        // 发送消息
        messageChannel2.send("发送给flutter的数据", new BasicMessageChannel.Reply<Object>() {
            @Override
            public void reply(Object o) {

                System.out.println("onReply: " + o);
            }
        });

        return batteryLevel;
    }

}
