// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TurnerController extends GetxController {
  final year = TextEditingController();
  final peso = TextEditingController();
  final estatura = TextEditingController();
  RxInt sexo = 1.obs;

/////////
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
/////////

  @override
  void onInit() {
    year.text = '3';
    peso.text = '10.5';
    estatura.text = '84.7';
    super.onInit();

/////////
    _createInterstitialAd();
/////////
  }

  actualizarTurner() {
/////////
    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
/////////

    year.value;
    estatura.value;
    peso.value;
    update();
  }

  /////////
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
/////////
}

class SalesTurner {
  SalesTurner(this.years, this.p_3, this.p_10, this.p_25, this.median,
      this.p_75, this.p_90, this.p_97);

  final int years;
  // ignore: non_constant_identifier_names
  final double p_3;
  // ignore: non_constant_identifier_names
  final double p_10;
  // ignore: non_constant_identifier_names
  final double p_25;
  final double median;
  // ignore: non_constant_identifier_names
  final double p_75;
  // ignore: non_constant_identifier_names
  final double p_90;
  // ignore: non_constant_identifier_names
  final double p_97;

  factory SalesTurner.fromJson(Map<String, dynamic> parsedjson) {
    return SalesTurner(
        parsedjson['years'],
        parsedjson['p_3'],
        parsedjson['p_10'],
        parsedjson['p_25'],
        parsedjson['median'],
        parsedjson['p_75'],
        parsedjson['p_90'],
        parsedjson['p_97']);
  }
}
