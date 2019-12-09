import 'dart:async';

import 'package:flutter/services.dart';

class FlutterFacebookAppLinks {
  static const MethodChannel _channel =
      const MethodChannel('flutter_facebook_app_links');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
