import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../data/models/video_model.dart';
import '../../../utils/api_key.dart';

class VideoController extends GetxController {
  String baseUrl = 'https://api.themoviedb.org/3/';

  final movieId = Get.arguments;

  RxList<Videos> videosList = <Videos>[].obs;
  void getVideos(int movieId) async {
    videosList.clear();
    String responseUrl = '${baseUrl}movie/$movieId/videos?api_key=$apiKey&append_to_response=videos';
    final response = await get(Uri.parse(responseUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['results']) {
        videosList.add(
            Videos.fromJson(e)
        );
      }
      print('videos key: ${videosList[1].key}');
      videosList.refresh();
    }
    else {
      throw Exception('Failed to load videos!');
    }
  }

  @override
  void onInit() {
    getVideos(movieId);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
