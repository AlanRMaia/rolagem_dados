import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<Future> showLoading() async {
  return Get.defaultDialog(
      title: "Loading...",
      content: const CircularProgressIndicator(),
      barrierDismissible: false);
}

dismissLoadingWidget() {
  Get.back();
}
