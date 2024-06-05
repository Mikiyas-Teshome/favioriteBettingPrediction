import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class AdManager {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;
  ValueNotifier<bool> adShowingNotifier = ValueNotifier(false);

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/1033173712', // Test ad unit ID, replace with your actual ad unit ID for production
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              adShowingNotifier.value = true;
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              adShowingNotifier.value = false;
              loadInterstitialAd(); // Load a new ad after dismissing the current one
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
              adShowingNotifier.value = false;
              loadInterstitialAd(); // Load a new ad if the current one fails to show
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      print('Interstitial ad is not ready yet');
    }
  }
}
