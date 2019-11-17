import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fflashlight/fflashlight.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasFlashlight = false;
  bool _flashlightState = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool hasFlashlight;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      hasFlashlight = await Fflashlight.hasFlashlight;
    } on PlatformException {
      hasFlashlight = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _hasFlashlight = hasFlashlight;
    });
  }

  void _onSwitchChanged(bool value) async {
    setState(() {
      _flashlightState = value;
    });

    await Fflashlight.enable(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fflashlight Example'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'hasFlashlight',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                ),
                subtitle: Text("$_hasFlashlight"),
              ),
              SwitchListTile(
                title: const Text("flashlightState"),
                secondary: _flashlightState ? const Icon(Icons.flash_on) : const Icon(Icons.flash_off),
                onChanged: _hasFlashlight ? _onSwitchChanged : null,
                value: _flashlightState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
