import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_details/app/modules/home/controllers/home_controller.dart';
import '../widgets/custom_get_snackbar.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  void _checkConnectivity(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      showCustomSnackbar(
        title: 'No Network!',
        message: 'Internet connection is required.',
        icon: Icons.wifi_off,
        durationSecond: 8192,
      );
    } else {
      HomeController.to.fetchMovies();
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_checkConnectivity);
  }
}
