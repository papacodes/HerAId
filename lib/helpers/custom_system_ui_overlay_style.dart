import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSystemUiOverlayStyle {
  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // Color(0xFF000000),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // Color(0xFF000000),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}
