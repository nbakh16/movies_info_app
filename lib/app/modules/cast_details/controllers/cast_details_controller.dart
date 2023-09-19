import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movies_details/app/data/models/cast_bio_model.dart';

import '../../../utils/api_key.dart';

class CastDetailsController extends GetxController {
  Rx<CastBio?> castInfo = Rx<CastBio?>(null);
  final castId = Get.arguments;

  Future<void> getCastInfo(int castId) async {
    final String responseUrl = 'https://api.themoviedb.org/3/person/$castId?api_key=$apiKey';

    final response = await get(Uri.parse(responseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      castInfo.value = CastBio.fromJson(data);
    } else {
      throw Exception('Failed to load actor data');
    }
  }

  @override
  void onInit() {
    getCastInfo(castId);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
