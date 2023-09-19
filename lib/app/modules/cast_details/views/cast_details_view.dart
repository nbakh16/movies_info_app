import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/widgets/custom_divider.dart';

import '../../../data/models/cast_bio_model.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_network_image.dart';
import '../controllers/cast_details_controller.dart';

class CastDetailsView extends GetView<CastDetailsController>{
  CastDetailsView({super.key});

  final CastDetailsController castDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                mainColor,
                mainColor,
                mainColor,
                mainColor.shade600,
                mainColor.shade700,
                mainColor.shade800,
                mainColor.shade900
              ]
          )
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Obx((){
              if(castDetailsController.castInfo.value == null) {
                return const CircularProgressIndicator();
              }
              else if (castDetailsController.castInfo.value == CastBio()) {
                return const Text('No Data!');
              }
              else {
                final castInfo = castDetailsController.castInfo.value;
                String castImage(String path) => 'https://image.tmdb.org/t/p/original$path';

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 450.0,
                      toolbarHeight: 110.0,
                      automaticallyImplyLeading: false,
                      elevation: 12,
                      leading: IconButton(
                        icon: const Icon(IconlyLight.arrowLeft2, size: 35),
                        onPressed: () => Get.back(),
                      ),
                      flexibleSpace: Center(
                        child: CustomNetworkImage(
                          imgUrl: castImage(castInfo?.profilePath ?? Icons.image.toString()),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(10),
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: mainColor.withOpacity(0.85),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Text(castInfo?.name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            )
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Visibility(
                        visible: castInfo!.birthday != null && castInfo.biography != "",
                        replacement: const Center(child: Text('Not enough data to show!')),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              castInfo.birthday == null ? const SizedBox() :
                              Text('Born: ${castInfo.birthday} (${castInfo.placeOfBirth})'),
                              castInfo.deathday == null ? const SizedBox() :
                              Text('Died: ${castInfo.deathday}'),
                              const CustomDivider(),
                              Text(
                                castInfo.biography ?? '',
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
          )
        ),
      ),
    );
  }
}
