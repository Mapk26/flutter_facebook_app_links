import Flutter
import UIKit
import FBSDKCoreKit


public class SwiftFlutterFacebookAppLinksPlugin: NSObject, FlutterPlugin {

  var deepLinkUrl:String = ""

  public static func register(with registrar: FlutterPluginRegistrar) {

    let instance = SwiftFlutterFacebookAppLinksPlugin()
    let channel = FlutterMethodChannel(name: "plugins.remedia.it/flutter_facebook_app_links", binaryMessenger: registrar.messenger())
    
    // Get user consent
    print("FB APP LINK registering plugin")
    
    instance.initializeSDK()
    
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
    // detach
  }

  public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {

      Settings.shared.isAdvertiserTrackingEnabled = false
      let launchOptionsForFacebook = launchOptions as? [UIApplication.LaunchOptionsKey: Any]
      ApplicationDelegate.shared.application(
          application,
          didFinishLaunchingWithOptions:
              launchOptionsForFacebook
      )
      AppLinkUtility.fetchDeferredAppLink{ (url, error) in
          if let error = error{
              print("Error %a", error)
          }
          if let url = url {
              self.deepLinkUrl = url.absoluteString
              // self.sendMessageToStream(link: self.deepLinkUrl)
          }
      }
      return true
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
        case "getPlatformVersion":
            handleGetPlatformVersion(call, result: result)
            break
        case "initFBLinks":
            ApplicationDelegate.shared.initializeSDK()
            result(nil)
            return
        case "getDeepLinkUrl":    
            result(deepLinkUrl)
        case "activateApp":
            AppEvents.shared.activateApp()
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    
  }

  private func handleGetPlatformVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }


  public func initializeSDK() {
    ApplicationDelegate.shared.initializeSDK()
  }

  
}


