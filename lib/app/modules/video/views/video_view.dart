import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/utils/my_formatter.dart';
import 'package:movies_details/app/widgets/custom_divider.dart';
import 'package:movies_details/app/widgets/shimmer_loading/container_shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  VideoView({super.key});

  final VideoController videoController = Get.find();
  late YoutubePlayerController? _controller;

  RxBool isPlayerReady = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trailers'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(IconlyLight.arrowLeft2),
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: videoController.videosList.length,
            itemBuilder: (context, index) {
              if (videoController.videosList.isNotEmpty) {
                _controller = YoutubePlayerController(
                  initialVideoId: videoController.videosList[index].key!,
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                    enableCaption: true,
                    mute: false,
                  ),
                );
              }

              return _controller == null
                  ? const ContainerShimmerLoading()
                  : Card(
                      color: mainColor,
                      clipBehavior: Clip.hardEdge,
                      elevation: 4.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0),
                      )),
                      child: Column(
                        children: [
                          YoutubePlayer(
                            controller: _controller!,
                            showVideoProgressIndicator: true,
                            onReady: () {
                              isPlayerReady.value = true;
                            },
                          ),
                          trailerInfo(context, index),
                        ],
                      ),
                    );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 14),
          ),
        );
      }),
    );
  }

  Column trailerInfo(BuildContext context, int index) {
    return Column(
      children: [
        const SizedBox(
          height: 4.0,
        ),
        Text(
          '${videoController.videosList[index].name}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          MyFormatter.formatDate(
              videoController.videosList[index].publishedAt?.split('T').first ??
                  ''),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const CustomDivider()
      ],
    );
  }
}
