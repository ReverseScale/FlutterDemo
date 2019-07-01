import 'main.dart';
import 'app_config.dart';
import 'package:flutter/material.dart';

void main() {
  var configuredApp = AppConfig(
    appName: 'Build flavors PRO',
    flavorName: 'production',
    apiBaseUrl: 'https://api.example.com/',
    child: MyApp(),
  );

  runApp(configuredApp);
}
