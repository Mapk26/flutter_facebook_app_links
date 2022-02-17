import FBSDKCoreKit
import Flutter
import UIKit

public class SwiftFlutterFacebookAppLinksPlugin: NSObject, FlutterPlugin {
  // fileprivate var resulter: FlutterResult? = nil

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.remedia.it/flutter_facebook_app_links", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterFacebookAppLinksPlugin()

    // Get user consent
    print("FB APP LINK registering plugin")
    ApplicationDelegate.shared.initializeSDK()

    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "consentProvided":
      Settings.shared.isAutoLogAppEventsEnabled = true
      ApplicationDelegate.shared.initializeSDK()
      result(nil)
    case "consentRevoked":
      Settings.shared.isAutoLogAppEventsEnabled = false
      ApplicationDelegate.shared.initializeSDK()
      result(nil)
    case "getPlatformVersion":
      handleGetPlatformVersion(call, result: result)
    case "initFBLinks":
      print("FB APP LINK launched")
      handleFBAppLinks(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func handleGetPlatformVersion(_: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

  private func handleFBAppLinks(_: FlutterMethodCall, result: @escaping FlutterResult) {
    print("FB APP LINKS Starting ")

    AppLinkUtility.fetchDeferredAppLink { url, error in
      if let error = error {
        print("Received error while fetching deferred app link %@", error)
        result(nil)
      }

      if let url = url {
        print("FB APP LINKS getting url: ", String(url.absoluteString))

        var mapData: [String: String?] = ["deeplink": url.absoluteString, "promotionalCode": nil]

        if let code = AppLinkUtility.appInvitePromotionCode(from: url) {
          print("promotional code " + String(code))
          mapData["promotionalCode"] = code
        } else { // nil
        }

        if #available(iOS 10, *) {
          result(mapData)
        } else {
          result(mapData)
        }
      } else {
        // no deep link received
        result(nil)
      }
    }
  }
}
