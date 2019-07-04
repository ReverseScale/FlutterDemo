package com.example.flutter_channel;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "samples.flutter.io/battery";

  private static final String CHANNEL_MESSAGE = "samples.flutter.io/message";

  private static final String APP_PACKAGE = "com.autonavi.minimap";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

//    MarketUtil.checkMarket(this);
//
//    MarketUtil.toMarket(this, APP_PACKAGE, null);
//
//    MarketUtil.toQQDownload(this, APP_PACKAGE);
//
//    MarketUtil.to360Download(this, APP_PACKAGE);
//
//    MarketUtil.toWandoujia(this, APP_PACKAGE);
//
//    MarketUtil.toXiaoMi(this, APP_PACKAGE);
//
//    MarketUtil.toMeizu(this, APP_PACKAGE);
//
//    MarketUtil.goToSamsungMarket(this, APP_PACKAGE);
//
//    MarketUtil.goToSonyMarket(this, "3502");

    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
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


    new MethodChannel(getFlutterView(), CHANNEL_MESSAGE).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                if (call.method.equals("getMessage")) {
                  result.success("Message: Hi");
                } else {
                  result.notImplemented();
                }
              }
            });

  }

  private void openGooglePlay() {
    MarketUtil.toMarket(this, APP_PACKAGE, null);
  }

  private int getBatteryLevel() {
    int batteryLevel = -1;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
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
