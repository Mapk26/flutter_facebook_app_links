# Flutter Facebook App Links

Flutter plugin for [Facebook App Links SDK](https://developers.facebook.com/docs/app-ads/deep-linking/). This plugin must be used to catch deferred deeplinks sent from Facebook after your app has been installed from a FB ADS.

## Getting Started

First of all, if you don't have one already, you must first create an app at Facebook developers: https://developers.facebook.com/

Get your app id (referred to as `[APP_ID]` below)


### Configure Android
For Android configuration, you can follow the same instructions of the Flutter Facebook App Events plugin:
Read through the "[Getting Started with App Events for Android](https://developers.facebook.com/docs/app-events/getting-started-app-events-android)" tutuorial and in particular, follow [step 2](https://developers.facebook.com/docs/app-events/getting-started-app-events-android#2--add-your-facebook-app-id) by adding the following into `/app/res/values/strings.xml` (or into respective `debug` or `release` build flavor)

```xml
<string name="facebook_app_id">[APP_ID]</string>
```

After that, add that string resource reference to your main `AndroidManifest.xml` file

```xml
<meta-data
  android:name="com.facebook.sdk.ApplicationId"
  android:value="@string/facebook_app_id" />
```


### Configure iOS
For iOS configuration, you can follow the same instructions of the Flutter Facebook App Events plugin:
Read through the "[Getting Started with App Events for iOS](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios)" tutuorial and in particular, follow [step 4](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios#plist-config) by opening `info.plist` "As Source Code" and add the following


 * If your code does not have `CFBundleURLTypes`, add the following just before the final `</dict>` element:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb[APP_ID]</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>[APP_ID]</string>
<key>FacebookDisplayName</key>
<string>[APP_NAME]</string>
```

 * If your code already contains `CFBundleURLTypes`, insert the following:

 ```xml
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb[APP_ID]</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>[APP_ID]</string>
<key>FacebookDisplayName</key>
<string>[APP_NAME]</string>
 ```

 ## About Facebook App Links
 Please refer to the official SDK documentation for [Android](https://developers.facebook.com/docs/app-ads/deep-linking/) and [iOS](https://developers.facebook.com/docs/app-ads/deep-linking/).

 ## IMPORTANT NOTES
 
 ### User privacy [DO NOT IGNORE]

 How documented on Facebook [docs](https://developers.facebook.com/docs/app-ads/deep-linking/), starting from v5.0.0 of the SDK, they introduce a flag for disabling automatic SDK initialization to be GDPR compliant.
 It means that you should collect user consent before you use call the method `initFBLinks()` of this plugin and save the user choice. Moreover, you should give the user a chance to revoke their consent in the future.
 Please keep in mind that this plugin uses `FacebookSDK.setAutoInitEnabled(true)` in Android and `Settings.isAutoInitEnabled = true` in iOS by default, so the consent must be granted in your Dart code before you call `FlutterFacebookAppLinks.initFBLinks()`.


 ### Testing deferred deep links

 To correctly test deferred deeplinks, DO NOT use the preview of your FB ADS campaign.
 Instead, use this tool [APP ADS HELPER](https://developers.facebook.com/tools/app-ads-helper)

 At the end of the page you will find a "Test deep link" button, 
 click on it and type your custom url scheme (deeplink), for example: myawesomeapp://screen/login

 Select the second checkbox (or both). Remember that to make it works, you'll need the Facebook app installed on your device (Android or iPhone) and you must be logged in with the same account you're using in the Facebook Developers console.

 Your app doesn't need to be published on the store, simply uninstall it and re-install using Android Studio/VSCode or XCode after you've sent the deferred deep link.