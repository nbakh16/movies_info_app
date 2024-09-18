import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_details/app/services/api_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_card_people.dart';
import '../../../../widgets/people_list_widget.dart';

class ElementsListWidget extends StatefulWidget {
  const ElementsListWidget(
      {super.key,
      required this.title,
      required this.elementsList,
      this.isCast = true});

  final String? title;
  final RxList elementsList;
  final bool isCast;

  @override
  State<ElementsListWidget> createState() => _ElementsListWidgetState();
}

class _ElementsListWidgetState extends State<ElementsListWidget> {
  PageController pageController =
      PageController(viewportFraction: Get.width < 700 ? 0.42 : 0.2);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PeopleListWidget(
      category: widget.title,
      listView: PageView.builder(
        controller: pageController,
        pageSnapping: true,
        padEnds: false,
        scrollDirection: Axis.horizontal,
        itemCount: widget.elementsList.length,
        itemBuilder: (context, index) {
          return CustomCardPeople(
            onTap: () {
              Get.toNamed(Routes.CAST_DETAILS,
                  arguments: widget.elementsList[index].id);
            },
            image:
                ApiService().imageUrl(widget.elementsList[index].profilePath),
            title: widget.elementsList[index].name.toString().trim(),
            subTitle: widget.isCast
                ? widget.elementsList[index].character.toString().trim()
                : widget.elementsList[index].job.toString().trim(),
            // subTitle: '(${crewList![index].job})',
          );
        },
      ),
    );
  }
}
