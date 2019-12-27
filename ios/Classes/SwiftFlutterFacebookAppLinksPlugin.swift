import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFlutterFacebookAppLinksPlugin: NSObject, FlutterPlugin {

  //fileprivate var resulter: FlutterResult? = nil

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.remedia.it/flutter_facebook_app_links", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterFacebookAppLinksPlugin()

    // Get user consent
    print("FB APP LINK registering plugin")
    Settings.isAutoInitEnabled = true
    ApplicationDelegate.initializeSDK(nil)

    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
        case "getPlatformVersion":
            handleGetPlatformVersion(call, result: result)
            break
        case "initFBLinks":
            //resulter = result
            print("FB APP LINK launched")
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

    AppLinkUtility.fetchDeferredAppLink { (url, error) in
        if let error = error {
          print("Received error while fetching deferred app link %@", error)
          result("error");
        }

        if let url = url {
          print("FB APP LINKS getting url ")
          if #available(iOS 10, *) {
            //print("FB APP LINKS getting url iOS 10+ ")
            result(url.absoluteString)
          } else {
            //print("FB APP LINKS getting url iOS 10- ")
            result(url.absoluteString)
          }
        }else{
          //print("FB APP LINKS ends with no deeplink ")
          result("nolink")
        }
    }
  }

  
}


