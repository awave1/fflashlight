import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fflashlight/fflashlight.dart';

void main() {
  const MethodChannel channel = MethodChannel('fflashlight');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Fflashlight.platformVersion, '42');
  });
}
