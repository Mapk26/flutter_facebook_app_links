# flutter_facebook_app_links_example

Demonstrates how to use the flutter_facebook_app_links plugin.

## Getting Started

You can use the following code inside a Stateful Widget, usually the root so that it will be triggered when your app is opened:

```dart
import 'package:flutter_facebook_app_links/flutter_facebook_app_links.dart';
import 'dart:io' show Platform;

void catchFBDeferredDeeplinks() async {
    
    if (Platform.isAndroid) {
      try{
        Map<String, String> data = await FlutterFacebookAppLinks.initFBLinks();

        if(data!=null && data['deeplink']!=null && data['deeplink'].isNotEmpty)
          manageDeepLink(data['deeplink']);

      }catch(e){
        print('Error on FB APP LINKS');
      }  
    
    } else if (Platform.isIOS) {
      try{
        var result = await FlutterFacebookAppLinks.initFBLinks();
        print('Link from FB APP LINKS: $result');
        if(result!=null && result.isNotEmpty && result!='nolink' && result!='error')
          manageDeepLink(result);

      }catch(e){
       print('Error on FB APP LINKS');
      }
      
    }
   
  }

void manageDeepLink(String url){
    /// ... do something with the received link
}

@override
void initState() {
    super.initState();
    catchFBDeferredDeeplinks();
}
```