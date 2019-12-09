#import "FlutterFacebookAppLinksPlugin.h"
#import <flutter_facebook_app_links/flutter_facebook_app_links-Swift.h>

@implementation FlutterFacebookAppLinksPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFacebookAppLinksPlugin registerWithRegistrar:registrar];
}
@end
