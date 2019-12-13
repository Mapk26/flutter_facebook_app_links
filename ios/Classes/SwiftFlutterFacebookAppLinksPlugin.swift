import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFlutterFacebookAppLinksPlugin: NSObject, FlutterPlugin {

  fileprivate var initialLink: String = "xxx"
  fileprivate var resulter: FlutterResult? = nil

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.remedia.it/flutter_facebook_app_links", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterFacebookAppLinksPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
        case "getPlatformVersion":
            handleGetPlatformVersion(call, result: result)
            break
        case "initFBLinks":
            resulter = result
            print("FB APP LINK started")
            handleFBAppLinks(call, result: result)
            break
        
        default:
            result(FlutterMethodNotImplemented)
        }
    
  }

  private func handleGetPlatformVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    result("iOS " + UIDevice.current.systemVersion)
  }

  private func handleFBAppLinks(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("FB APP LINKS Starting ")
    // Get user consent
    Settings.isAutoInitEnabled = true
    ApplicationDelegate.initializeSDK(nil)
    AppLinkUtility.fetchDeferredAppLink { (url, error) in
        if let error = error {
            print("Received error while fetching deferred app link %@", error)
        }

        if let url = url {
          print("FB APP LINKS getting url ")
            if #available(iOS 10, *) {
              //print("FB APP LINKS getting url iOS 10+ ")
              result(url.absoluteString)
                //UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
              //print("FB APP LINKS getting url iOS 10- ")
              result(url.absoluteString)
                //UIApplication.shared.openURL(url)
            }
        }else{
          //print("FB APP LINKS ends with no deeplink ")
          result("")
        }
    }
  }

  
}


