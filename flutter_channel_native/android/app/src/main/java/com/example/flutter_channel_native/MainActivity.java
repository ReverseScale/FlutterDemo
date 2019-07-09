package com.example.flutter_channel_native;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.StandardMessageCodec;
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
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.io/battery";
    private static final String CHANNEL2 = "samples.flutter.io/test";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);


        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        // TODO
                        if (call.method.equals("getBatteryLevel")) {
                            int batteryLevel = getBatteryLevel();

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
