import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

// have only 15 items rendered at first ...
class AllTransactions extends StatelessWidget {
  final int accCode;
  final String accName;

  AllTransactions({Key? key, required this.accCode, required this.accName})
      : super(key: key);

  final controller = Get.find<EntryControlls>();

  @override
  Widget build(BuildContext context) {
    controller.getAllEntry(accCode);
    return Scaffold(
      backgroundColor: iconwhite,
      appBar: AppBar(
        leadingWidth: 30,
        backgroundColor: secondaryC,
        iconTheme: IconThemeData(color: iconGreen),
        systemOverlayStyle: appStyle,
        title: Row(
          children: [
            contactI,
            Text(
              accName,
              style: appbarStyle,
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: SizedBox(
              child: Row(children: [handI, select]),
            ),
          )
        ],
      ),
      // HAVE A NAVIGATION BAR ALSO
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "tot".tr + "ent".tr + " :",
                style: subTitle,
              ),
              Text(
                "acctypee".tr + " : ",
                style: subTitle,
              )
            ],
          ),
          //InfoTile(controller.getAllEntry(accCode)[0], 0)
        ],
      ),
    );
  }
}
