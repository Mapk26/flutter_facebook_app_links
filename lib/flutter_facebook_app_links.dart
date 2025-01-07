import 'dart:async';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart';

class FlutterFacebookAppLinks {
  static const MethodChannel _channel = const MethodChannel("plugins.remedia.it/flutter_facebook_app_links");

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> initFBLinks() async {
    try {
      var data = await _channel.invokeMethod('initFBLinks');
      debugPrint('Deferred FB Link: $data');
      return data ?? '';
    } catch (e) {
      debugPrint("Error initializing FlutterFacebookAppLinks: $e");

      return '';
    }
  }

  static Future<String> getDeepLink() async {
    try {
      var data = await _channel.invokeMethod('getDeepLinkUrl');
      debugPrint('Deferred FB Link: $data');
      return data ?? '';
    } catch (e) {
      debugPrint("Error retrieving deferred deep link: $e");

      return '';
    }
  }

  static Future<void> activateSDK() async {
    try {
      debugPrint('Activating SDK');
      await _channel.invokeMethod('activateApp');
    } catch (e) {
      debugPrint("Error activating SDK: $e");
    }
  }
}
