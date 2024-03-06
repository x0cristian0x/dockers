// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DownMonthsController extends GetxController {
  final mes = TextEditingController();
  final peso = TextEditingController();
  final estatura = TextEditingController();
  final head = TextEditingController();
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
    super.onInit();
    mes.text = "1";
    peso.text = "3.9";
    estatura.text = "52.6";
    head.text = "35.9";

/////////
    _createInterstitialAd();
/////////
  }

  actualizarDownMonths_1() {
    /////////
    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
/////////

    mes.value;
    estatura.value;
    head.value;
    peso.value;
    update();
  }

  actulizarDownMonths_1() {
    sexo;
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

class SalesDownMonth {
  SalesDownMonth(this.months, this.sd_iz_2, this.sd_iz_1, this.median,
      this.sd_de_1, this.sd_de_2, this.sex);

  final int months;
  // ignore: non_constant_identifier_names
  final double sd_iz_2;
  // ignore: non_constant_identifier_names
  final double sd_iz_1;
  final double median;
  // ignore: non_constant_identifier_names
  final double sd_de_1;
// ignore: non_constant_identifier_names
  final double sd_de_2;
  final String sex;

  factory SalesDownMonth.fromJson(Map<String, dynamic> parsedjson) {
    return SalesDownMonth(
        parsedjson['months'],
        parsedjson['sd_iz_2'],
        parsedjson['sd_iz_1'],
        parsedjson['median'],
        parsedjson['sd_de_1'],
        parsedjson['sd_de_2'],
        parsedjson['sex'].toString());
  }
}
