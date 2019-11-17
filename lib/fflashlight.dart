import 'dart:async';

import 'package:flutter/services.dart';

class Fflashlight {
  static const MethodChannel _channel = const MethodChannel('fflashlight');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> get hasFlashlight async {
    return await _channel.invokeMethod("hasFlashlight");
  }
  
  static Future<void> on() async {
    return await _channel.invokeMethod('on');
  }

  static Future<void> off() async {
    return await _channel.invokeMethod('on');
  }
  
  static Future<void> enable(bool state) async {
    return await _channel.invokeMethod('enable', { 'state': state });
  }
}
