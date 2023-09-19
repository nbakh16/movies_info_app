import 'package:flutter/material.dart';
import 'custom_divider.dart';

class PeopleListWidget extends StatelessWidget {
  const PeopleListWidget({
    super.key,
    this.category,
    this.listView
  });

  final String? category;
  final Widget? listView;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return SliverToBoxAdapter(
        child: SizedBox(
          height: screenHeight<400 ? screenHeight*0.25 : screenWidth<700 ? screenHeight*0.35 : screenHeight*0.65,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.all(8.0, ),
                  child: Text(category!,
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                ),
                Expanded(
                  child: listView!
                )
              ],
            ),
          ),
        )
    );
  }
}