import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutteruapp/res/AppString.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class Ads {
  static BannerAd _bannerAd;
  static InterstitialAd _interstitialAd;
  static bool _adShown = false;

  static void initialize() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return AppString.BANNER_AD_UNIT_IOS;
    } else if (Platform.isAndroid) {
      return AppString.BANNER_AD_UNIT_ANDROID;
    }
    return null;
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return AppString.INTERSTITIAL_AD_UNIT_IOS;
    } else if (Platform.isAndroid) {
      return AppString.INTERSTITIAL_AD_UNIT_ANDROID;
    }
    return null;
  }

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: AdSize.fullBanner,
      //targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event = $event");
      },
    );
  }

  static InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: getInterstitialAdUnitId(),
      //targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event = $event");
      },
    );
  }

  static void showBannerAd() {
    if (_bannerAd == null) _bannerAd = createBannerAd();
    _bannerAd
      ..load()
      ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
    _adShown = true;
  }

  static void showInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();
    _interstitialAd?.show();
  }

  static void hideBannerAd() async {
    if (_bannerAd != null) await _bannerAd.dispose();
    _bannerAd = null;
    _adShown = false;
  }

  static bool isBannerAdsShowing() {
    return _bannerAd == null ? false : true;
  }
}
