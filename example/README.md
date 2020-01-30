# flutter_facebook_app_links_example

Demonstrates how to use the flutter_facebook_app_links plugin.

## Getting Started

You can use the following code inside a Stateful Widget, usually the root so that it will be triggered when your app is opened:

```dart
import 'package:flutter_facebook_app_links/flutter_facebook_app_links.dart';

void catchFBDeferredDeeplinks() async {
    
    try{
      Map<String, String> data = await FlutterFacebookAppLinks.initFBLinks();

      if(data!=null && data['deeplink']!=null && data['deeplink'].isNotEmpty){
        /// do stuffs with the deeplink
      }

      if(data!=null && data['promotionalCode']!=null && data['promotionalCode'].isNotEmpty){
        /// do stuffs with the promo code
      }

    }catch(e){
      print('Error on FB APP LINKS');
    }  
   
}


@override
void initState() {
    super.initState();
    catchFBDeferredDeeplinks();
}
```