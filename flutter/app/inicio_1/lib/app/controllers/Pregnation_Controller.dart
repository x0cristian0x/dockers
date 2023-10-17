// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PregnationController extends GetxController {
  final week = TextEditingController();
  final estatura = TextEditingController();
  final peso = TextEditingController();
  RxInt autor = 1.obs;

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
    super.onInit();
    autor;
    week.text = "10";
    estatura.text = "165";
    peso.text = "76";

/////////
    _createInterstitialAd();
/////////
  }

  actualizarPregnation_1() {
/////////
    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
/////////
    week.value;
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

class SalesPregnation {
  SalesPregnation(this.weeks, this.bajopeso, this.sobrepeso, this.obesidad,
      this.maximo, this.autor);

  final int weeks;
  final double bajopeso;
  final double sobrepeso;
  final double obesidad;
  final double maximo;
  final String autor;
  factory SalesPregnation.fromJson(Map<String, dynamic> parsedjson) {
    return SalesPregnation(
        parsedjson['weeks'],
        parsedjson['bajopeso'],
        parsedjson['sobrepeso'],
        parsedjson['obesidad'],
        parsedjson['maximo'],
        parsedjson['autor'].toString());
  }
}
