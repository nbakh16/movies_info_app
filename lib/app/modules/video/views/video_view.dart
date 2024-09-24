import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../utils/colors.dart';
import '../../../utils/my_formatter.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/shimmer_loading/container_shimmer.dart';
import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  VideoView({super.key});

  final VideoController videoController = Get.find();
  late YoutubePlayerController? _controller;

  RxBool isPlayerReady = false.obs;

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.sizeOf(context).width;
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
          child: GridView.builder(
            itemCount: videoController.videosList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenW < 700 ? 1 : (screenW < 900 ? 2 : 3),
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.3,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (videoController.videosList.isNotEmpty) {
                _controller = YoutubePlayerController(
                  //avengers
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
            // separatorBuilder: (_, __) => const SizedBox(height: 14),
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
