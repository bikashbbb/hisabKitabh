import 'dart:ui';

import 'package:app/palette/commonWidgets/ctextfields.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/dialogs/con.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

// how will i fix the amount shit
/// yo dialog machai hamile k garxam vanda kheri we will get the controller ani controller ko varibale chai change vairakxa from the entry controller !!!
class DeleteAccDialog extends StatelessWidget {
  final String title;
  final String totalAccCount;
  final bool ishome;

  DeleteAccDialog(this.title, this.totalAccCount,
      {Key? key, this.ishome = true})
      : super(key: key);

  late String deletedCount;
  late String currentAcc;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<DialogControlls>(
          init: DialogControlls(),
          builder: (c) {
            currentAcc =
                c.isFinished ? totalAccCount : c.cureentAccIndex.toString();
            deletedCount = c.currentIndex.toString();
            return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: AlertDialog(
                  contentPadding: const EdgeInsets.only(top: 16),
                  actionsPadding: const EdgeInsets.only(bottom: 0, left: 10),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "del".tr +
                            " $deletedCount/" +
                            c.totalRcordCount.toString(),
                        style: optionalstyles(Colors.black54),
                      ),
                      Text(
                        "tot".tr + ": $currentAcc/ $totalAccCount",
                        style: optionalstyles(Colors.black54),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  titlePadding: const EdgeInsets.only(left: 19),
                  title: Center(
                    child: Text(
                      title,
                      style: appbarStyle,
                    ),
                  ),
                  actions: [
                    LinearPercentIndicator(
                      animation: true,
                      width: 280.w,
                      lineHeight: 5.0,
                      percent:
                          1, //c.getPercentage().isNaN ? 0 : c.getPercentage(),
                      backgroundColor: Colors.grey,
                      progressColor: iconGreen,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 10),
                      child: SizedBox(
                        width: c.isFinished ? 50 : 25,
                        height: 25,
                        child: c.isFinished
                            ? InkWell(
                                onTap: ishome
                                    ? c.onDoneClickedHome
                                    : () async {
                                        await Get.delete<DialogControlls>();
                                        Navigator.pop(context);
                                      },
                                child: Text(
                                  'Done!',
                                  style: TextStyle(
                                      color: iconGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                )) // done button here !!...
                            : CircularProgressIndicator(
                                strokeWidth: 3,
                                color: iconGreen,
                              ),
                      ),
                    ),
                  ],
                ));
          }),
    );
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

void confirmDialog(Function(bool) onYes, bool isHome) {
  Get.dialog(AlertDialog(
    backgroundColor: Colors.white,
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

void showIndicatorDialog(bool isSucess) {
  Get.dialog(AlertDialog(
    backgroundColor: Colors.white,
    title: Center(
      child: isSucess
          ? Text(
              "failed".tr,
              style: subTitle,
            )
          : CircularProgressIndicator(
              color: iconGreen,
            ),
    ),
  ));
}

void settleDialog(TextEditingController tCon, bool issale, Function onTap) {
  Get.dialog(AlertDialog(
    actionsPadding: EdgeInsets.zero,
    backgroundColor: Colors.white,
    titlePadding: const EdgeInsets.only(left: 24, bottom: 10),
    contentPadding: const EdgeInsets.only(right: 24, left: 24),
    title: Text(
      'Settlement',
      style: appbarStyle,
    ),
    content: addTransactionField("Amount", con: tCon),
    actions: [
      TextButton(
          onPressed: () {
            onTap();
          },
          child: salesIcon(issale))
    ],
  ));
}

