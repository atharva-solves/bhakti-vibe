import 'dart:async';

import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint('1. Splash Controller Initialized');
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Timer(const Duration(seconds: 3), () {
      debugPrint('2.splash ctr> Timer finished, attempting navigation');
      Get.offAllNamed(AppRoutes.rootDashboard);
    });
  }
}
