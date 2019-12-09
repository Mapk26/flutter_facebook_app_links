import Flutter
import UIKit

public class SwiftFlutterFacebookAppLinksPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_facebook_app_links", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterFacebookAppLinksPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
