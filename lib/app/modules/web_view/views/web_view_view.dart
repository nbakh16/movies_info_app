import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/utils/colors.dart';

import '../controllers/web_view_controller.dart';

class WebViewView extends GetView<WebViewController> {
  WebViewView({super.key});
  final WebViewController webViewController = Get.find<WebViewController>();

  @override
  Widget build(BuildContext context) {
    late InAppWebViewController inAppWebViewController;

    final String url = Get.arguments;
    webViewController.setWebUrl(url);

    return WillPopScope(
      onWillPop: () async {
        bool canGoBack = await inAppWebViewController.canGoBack();

        if(canGoBack) {
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  // url: Uri.parse('https://food52.com/recipes/83097-chicken-stew')
                    url: Uri.parse(webViewController.webUrl.value)
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  webViewController.progress.value = progress / 100;
                },
              ),
              Obx(()=>
                Visibility(
                  visible: webViewController.progress.value < 1,
                  replacement: const SizedBox(),
                  child: LinearProgressIndicator(
                    minHeight: 12.0,
                    value: webViewController.progress.value,
                    backgroundColor: mainColor.shade200,
                    color: mainColor,
                  )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
