import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_card_people.dart';
import '../../../../widgets/people_list_widget.dart';

class ElementsListWidget extends StatelessWidget {
  const ElementsListWidget(
      {super.key,
      required this.title,
      required this.elementsList,
      this.isCast = true});

  final String title;
  final RxList elementsList;
  final bool isCast;

  @override
  Widget build(BuildContext context) {
    return PeopleListWidget(
        category: title,
        listView: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: elementsList.length,
            itemBuilder: (context, index){
              return CustomCardPeople(
                onTap: () {
                  Get.toNamed(Routes.CAST_DETAILS,
                      arguments: elementsList[index].id
                  );
                },
                image: 'https://image.tmdb.org/t/p/original${elementsList[index].profilePath}',
                title: elementsList[index].name.toString().trim(),
                subTitle: isCast
                    ? elementsList[index].character.toString().trim()
                    : elementsList[index].job.toString().trim(),
                // subTitle: '(${crewList![index].job})',
              );
            }
        )
    );
  }
}
