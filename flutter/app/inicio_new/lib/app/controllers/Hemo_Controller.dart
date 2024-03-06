// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HemoController extends GetxController {
  final clasificacion = TextEditingController();
  final hemoglobina = TextEditingController();
  final opcional = TextEditingController();

  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-2015860081666244/8791682096",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    clasificacion.text = '0';
    hemoglobina.text = '0';
    opcional.text = '0';

    _createInterstitialAd();
  }

  actualizarHemo() {
    clasificacion.value;
    hemoglobina.value;
    opcional.value;

    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
    update();
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;

    _interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      _interstitialAd.dispose();
      _createInterstitialAd();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      _interstitialAd.dispose();
      _createInterstitialAd();
    });
  }
}
