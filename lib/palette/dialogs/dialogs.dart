import 'dart:ui';

import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

/// yo dialog machai hamile k garxam vanda kheri we will get the controller ani controller ko varibale chai change vairakxa from the entry controller !!!
class DeleteAccDialog extends StatelessWidget {
  final String title;
  final String totalAccCount;
  final String totalCount;

  const DeleteAccDialog(this.title, this.totalAccCount, this.totalCount,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.only(left: 19),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "del".tr + " / $totalCount",
                      style: optionalstyles(Colors.black54),
                    ),
                  ),
                  Text(
                    "tacc".tr + "/ $totalAccCount",
                    style: optionalstyles(Colors.black54),
                  ),
                ],
              )
            ],
          ),
          actions: [
            LinearPercentIndicator(
              animation: true,
              width: 260.w,
              lineHeight: 5.0,
              percent: 0.8,
              backgroundColor: Colors.grey,
              progressColor: iconGreen,
            ),
          ],
        ));
  }
}

void deleteAccDialog() {
  /* Get.dialog(
    AlertDialog(
      backgroundColor: Colors.green.withOpacity(0.8),
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: const [
        CircularProgressIndicator(
          color: Colors.white,
        ),
      ],
    ),
    barrierDismissible: false,
  ); */
}

confirmDialog(Function(bool) onYes, bool isHome) {
  Get.dialog(AlertDialog(
    title: Text(
      'con'.tr,
      style: TextStyle(color: black),
    ),
    content: Row(
      children: [
        Expanded(
            child: MaterialButton(
                color: iconGreen,
                onPressed: () {
                  Get.back();
                  onYes(isHome);
                },
                child: Text(
                  'y'.tr,
                  style: white15,
                ))),
        SizedBox(
          width: 6.w,
        ),
        Expanded(
            child: MaterialButton(
                color: red,
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'n'.tr,
                  style: white15,
                )))
      ],
    ),
  ));
}
