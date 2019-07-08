package com.example.flutter_channel_native;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.app.AlertDialog;
import android.util.Log;
import android.widget.Toast;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "samples.flutter.io/battery";
  private static final String CHANNEL_MESSAGE = "samples.flutter.io/message";

  private MethodChannel mMethodChannel;
  private EventChannel.EventSink mEventSink;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

      getBattery();

      getMessage();


      listenAlert();
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

      mMethodChannel = new MethodChannel(getFlutterView(), "samples.flutter.io/message");

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

}
