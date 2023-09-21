import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  VideoView({super.key});

  final VideoController videoController = Get.find();

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'D3NpwOB69Ys',
      // initialVideoId: videoController.videosList[1].key!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        mute: false
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.metadata.title),
        centerTitle: true,
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('${_controller.metadata.duration}');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
