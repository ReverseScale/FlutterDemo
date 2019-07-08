package com.example.flutter_channel_native;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "samples.flutter.io/battery";

  private static final String CHANNEL_MESSAGE = "samples.flutter.io/message";

  private static final String APP_PACKAGE = "com.autonavi.minimap";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

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
