import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../modules/movie_search/views/movie_search_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  const CustomAppBar({
    this.title = 'Default Title',
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 2,
      actions: [
        IconButton(onPressed: (){
          Get.to(()=>MovieSearchView());
        }, icon: const Icon(IconlyLight.search))
      ],
    );
  }
}