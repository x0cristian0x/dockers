// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RNController extends GetxController {
  final week = TextEditingController();
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
    week.text = '0';
    peso.text = '3.3';
    estatura.text = '49.9';
    head.text = '34.5';
    super.onInit();

/////////
    _createInterstitialAd();
/////////
  }

  actualizarRN() {
    week.value;
    estatura.value;
    head.value;
    peso.value;
    update();

/////////
    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
/////////
  }

  actulizarRN2() {
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

class SalesWeek {
  SalesWeek(this.weeks, this.sd_iz_3, this.sd_iz_2, this.sd_iz_1, this.median,
      this.sd_de_1, this.sd_de_2, this.sd_de_3, this.sex);

  final int weeks;
  // ignore: non_constant_identifier_names
  final double sd_iz_3;
  // ignore: non_constant_identifier_names
  final double sd_iz_2;
  // ignore: non_constant_identifier_names
  final double sd_iz_1;
  final double median;
  // ignore: non_constant_identifier_names
  final double sd_de_1;
  // ignore: non_constant_identifier_names
  final double sd_de_2;
  // ignore: non_constant_identifier_names
  final double sd_de_3;
  final String sex;

  factory SalesWeek.fromJson(Map<String, dynamic> parsedjson) {
    return SalesWeek(
        parsedjson['weeks'],
        parsedjson['sd_iz_3'],
        parsedjson['sd_iz_2'],
        parsedjson['sd_iz_1'],
        parsedjson['median'],
        parsedjson['sd_de_1'],
        parsedjson['sd_de_2'],
        parsedjson['sd_de_3'],
        parsedjson['sex'].toString());
  }
}

class SalesRNWater {
  SalesRNWater(this.weeks, this.medianDA, this.medianDC, this.sex);

  final int weeks;
  // ignore: non_constant_identifier_names
  final double medianDA;
  // ignore: non_constant_identifier_names
  final double medianDC;
  // ignore: non_constant_identifier_names
  final String sex;

  factory SalesRNWater.fromJson(Map<String, dynamic> parsedjson) {
    return SalesRNWater(parsedjson['weeks'], parsedjson['medianDA'],
        parsedjson['medianDC'], parsedjson['sex'].toString());
  }
}
