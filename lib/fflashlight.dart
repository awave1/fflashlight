import 'dart:async';

import 'package:flutter/services.dart';

class Fflashlight {
  static const MethodChannel _channel = const MethodChannel('fflashlight');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
