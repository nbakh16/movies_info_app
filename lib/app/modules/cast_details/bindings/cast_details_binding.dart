import 'package:get/get.dart';

import '../controllers/cast_details_controller.dart';

class CastDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CastDetailsController>(
      () => CastDetailsController(),
    );
  }
}
