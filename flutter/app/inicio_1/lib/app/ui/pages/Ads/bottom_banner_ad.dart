import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:inicio_1/app/ui/pages/Ads/ad_service.dart';

class BottomBannerAd extends StatefulWidget {
  const BottomBannerAd({super.key});

  @override
  State<StatefulWidget> createState() => _BottomBannerAdState();
}

class _BottomBannerAdState extends State<BottomBannerAd> {
  // Banner ads automatically show new ads after a certain period of time.
  // You do not need to do anything fancy with timers or resetting this variable.
  final banner = GetIt.instance.get<AdService>().getBannerAd();

  @override
  void dispose() {
    banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: banner.size.height.toDouble(),
      child: AdWidget(ad: banner),
    );
  }
}
