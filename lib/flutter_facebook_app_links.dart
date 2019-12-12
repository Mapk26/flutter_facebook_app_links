import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

class FlutterFacebookAppLinks {
  static const MethodChannel _channel =
      const MethodChannel("plugins.remedia.it/flutter_facebook_app_links");

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> initFBLinks() async {

    if (Platform.isAndroid) {
      var data = await _channel.invokeMethod('initFBLinks');
      final Map<String, String> init = new Map.from(data);
      return init;
    } else if (Platform.isIOS) {
      var resutl = await _channel.invokeMethod('initFBLinks');
      return resutl;
    }
    
  }

}
