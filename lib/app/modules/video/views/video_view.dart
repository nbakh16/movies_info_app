import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  VideoView({super.key});

  final VideoController videoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VideoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'VideoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
