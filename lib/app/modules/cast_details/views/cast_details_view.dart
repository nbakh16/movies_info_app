import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cast_details_controller.dart';

class CastDetailsView extends GetView<CastDetailsController> {
  const CastDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CastDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CastDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
