<<<<<<< HEAD
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class OMSController extends GetxController {
  final mes = TextEditingController();
  final estatura = TextEditingController();
  final peso = TextEditingController();
  final head = TextEditingController();
  final arm = TextEditingController();

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
    mes.text = ' 0';
    estatura.text = '49.9';
    peso.text = '3.3';
    sexo;
    head.text = '0';
    arm.text = '0';

/////////
    _createInterstitialAd();
/////////
  }

  @override
  void onClose() {
    super.onClose();
    mes.dispose();
  }

  actualizarOMS() {
/////////
    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
/////////

    mes.value;
    estatura.value;
    head.value;
    arm.value;
    peso.value;
    update();
  }

  actulizar2() {
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

class SalesDetails {
  SalesDetails(this.months, this.sd_iz_3, this.sd_iz_2, this.sd_iz_1,
      this.median, this.sd_de_1, this.sd_de_2, this.sd_de_3, this.sex);

  final int months;
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

  factory SalesDetails.fromJson(Map<String, dynamic> parsedjson) {
    return SalesDetails(
        parsedjson['months'],
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

class SalesDetailsEspecial {
  SalesDetailsEspecial(this.cm, this.sd_iz_3, this.sd_iz_2, this.sd_iz_1,
      this.median, this.sd_de_1, this.sd_de_2, this.sd_de_3, this.sex);

  final double cm;
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

  factory SalesDetailsEspecial.fromJson(Map<String, dynamic> parsedjson) {
    return SalesDetailsEspecial(
        parsedjson['cm'],
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

class SalesWaterlow {
  SalesWaterlow(this.months, this.medianDA, this.medianDC, this.sex);

  final int months;
  final double medianDA;
  final double medianDC;
  final String sex;

  factory SalesWaterlow.fromJson(Map<String, dynamic> parsedjson) {
    return SalesWaterlow(parsedjson['months'], parsedjson['medianDA'],
        parsedjson['medianDC'], parsedjson['sex'].toString());
  }
}
=======
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class OMSController extends GetxController {
  final mes = TextEditingController();
  final estatura = TextEditingController();
  final peso = TextEditingController();
  final head = TextEditingController();
  final arm = TextEditingController();

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
    mes.text = ' 0';
    estatura.text = '49.9';
    peso.text = '3.3';
    sexo;
    head.text = '0';
    arm.text = '0';

/////////
    _createInterstitialAd();
/////////
  }

  @override
  void onClose() {
    super.onClose();
    mes.dispose();
  }

  actualizarOMS() {
/////////
    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
/////////

    mes.value;
    estatura.value;
    head.value;
    arm.value;
    peso.value;
    update();
  }

  actulizar2() {
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

class SalesDetails {
  SalesDetails(this.months, this.sd_iz_3, this.sd_iz_2, this.sd_iz_1,
      this.median, this.sd_de_1, this.sd_de_2, this.sd_de_3, this.sex);

  final int months;
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

  factory SalesDetails.fromJson(Map<String, dynamic> parsedjson) {
    return SalesDetails(
        parsedjson['months'],
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

class SalesDetailsEspecial {
  SalesDetailsEspecial(this.cm, this.sd_iz_3, this.sd_iz_2, this.sd_iz_1,
      this.median, this.sd_de_1, this.sd_de_2, this.sd_de_3, this.sex);

  final double cm;
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

  factory SalesDetailsEspecial.fromJson(Map<String, dynamic> parsedjson) {
    return SalesDetailsEspecial(
        parsedjson['cm'],
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

class SalesWaterlow {
  SalesWaterlow(this.months, this.medianDA, this.medianDC, this.sex);

  final int months;
  final double medianDA;
  final double medianDC;
  final String sex;

  factory SalesWaterlow.fromJson(Map<String, dynamic> parsedjson) {
    return SalesWaterlow(parsedjson['months'], parsedjson['medianDA'],
        parsedjson['medianDC'], parsedjson['sex'].toString());
  }
}
>>>>>>> rama_3
