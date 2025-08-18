package it.remedia.flutter_facebook_app_links;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
//import android.util.Log;

import com.facebook.applinks.AppLinkData;
import com.facebook.FacebookSdk;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterFacebookAppLinksPlugin */
public class FlutterFacebookAppLinksPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

  private Context mContext;
  private Activity mActivity;
  private MethodChannel channel;

  private static final String CHANNEL = "plugins.remedia.it/flutter_facebook_app_links";

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL);
    channel.setMethodCallHandler(this);
    mContext = binding.getApplicationContext();
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
    mContext = null;
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    mActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    mActivity = null;
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    mActivity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    mActivity = binding.getActivity();
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("initFBLinks")){
      initFBLinks(result);
    } else if (call.method.equals("getDeepLinkUrl")) {
      getDeepLinkUrl(result);
    } else if (call.method.equals("consentProvided")) {
      FacebookSdk.setAutoLogAppEventsEnabled(true);
      FacebookSdk.setAutoInitEnabled(true);
      FacebookSdk.fullyInitialize();
      result.success("");
    } else if (call.method.equals("consentRevoked")) {
      FacebookSdk.setAutoLogAppEventsEnabled(false);
      FacebookSdk.setAutoInitEnabled(false);
      FacebookSdk.fullyInitialize();
      result.success("");
    } else {
      result.notImplemented();
    }
  }

  private void getDeepLinkUrl(Result result) {
    //Log.d("FB_APP_LINKS", "Facebook App Links getDeepLinkUrl called");

    final Result resultDelegate = result;
    // Get a handler that can be used to post to the main thread
    final Handler mainHandler = new Handler(mContext.getMainLooper());

    // Get user consent
    FacebookSdk.fullyInitialize();
    AppLinkData.fetchDeferredAppLinkData(mContext,
      new AppLinkData.CompletionHandler() {
        @Override
        public void onDeferredAppLinkDataFetched(AppLinkData appLinkData) {
          // Process app link data
          if(appLinkData!=null && appLinkData.getTargetUri()!=null){
            //Log.d("FB_APP_LINKS", "Deep Link URL Received: " + appLinkData.getTargetUri().toString());
            
            Runnable myRunnable = new Runnable() {
              @Override
              public void run() {
                if(resultDelegate!=null)
                  resultDelegate.success(appLinkData.getTargetUri().toString());
              }
            };

            mainHandler.post(myRunnable);

          }else{
            //Log.d("FB_APP_LINKS", "Deep Link URL Received: null link");

            Runnable myRunnable = new Runnable() {
              @Override
              public void run() {
                if(resultDelegate!=null)
                  resultDelegate.success("");
              }
            };

            mainHandler.post(myRunnable);

          }

        }
      }
    );
  }

  private void initFBLinks(Result result) {
    //Log.d("FB_APP_LINKS", "Facebook App Links initialized");

    final Map<String, String> data = new HashMap<>();
    final Result resultDelegate = result;
    // Get a handler that can be used to post to the main thread
    final Handler mainHandler = new Handler(mContext.getMainLooper());

    // Get user consent
    FacebookSdk.fullyInitialize();
    AppLinkData.fetchDeferredAppLinkData(mContext,
      new AppLinkData.CompletionHandler() {
        @Override
        public void onDeferredAppLinkDataFetched(AppLinkData appLinkData) {
          // Process app link data
          if(appLinkData!=null) {

            if(appLinkData.getTargetUri()!=null){
              //Log.d("FB_APP_LINKS", "Deferred Deeplink Received: " + appLinkData.getTargetUri().toString());
              data.put("deeplink", appLinkData.getTargetUri().toString());
            }

            //Log.d("FB_APP_LINKS", "Deferred Deeplink Received: " + appLinkData.getPromotionCode());
            if(appLinkData.getPromotionCode()!=null)
              data.put("promotionalCode", appLinkData.getPromotionCode());
            else
              data.put("promotionalCode", "");

            Runnable myRunnable = new Runnable() {
              @Override
              public void run() {
                if(resultDelegate!=null)
                  resultDelegate.success(data);
              }
            };

            mainHandler.post(myRunnable);

          }else{
            //Log.d("FB_APP_LINKS", "Deferred Deeplink Received: null link");

            Runnable myRunnable = new Runnable() {
              @Override
              public void run() {
                if(resultDelegate!=null)
                  resultDelegate.success(null);
              }
            };

            mainHandler.post(myRunnable);

          }

        }
      }
    );
  }


}
