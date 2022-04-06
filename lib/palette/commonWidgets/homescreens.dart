import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

class DataScreen extends StatefulWidget {
  final bool isDaily;

  const DataScreen({Key? key, this.isDaily = true}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  var controller = Get.find<EntryControlls>();

  @override
  Widget build(BuildContext context) {
    int tLen = controller.getAccData.length;
    return Scaffold(
      backgroundColor: iconwhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "tacc".tr,
                style: headerS(Colors.black54),
              ),
              Padding(
                padding: EdgeInsets.only(right: 160.w),
                child: Text(
                  tLen.toString(),
                  style: headerS(Colors.black),
                ),
              ),
              handI,
              Padding(
                  padding: const EdgeInsets.only(right: 8.0), child: select),
            ],
          ),
          Divider(
            color: black,
            thickness: 1,
            height: 20.h,
          ),
          // lets have a list builder
          Expanded(
              child: AnimatedList(
                  key: accListKey,
                  initialItemCount: tLen,
                  itemBuilder: (ct, i, animate) {
                    return accCard(controller.getAccData[i]);
                  })),
          Align(
            child: widget.isDaily ? dailyButton : Text("here "),
          ),
          const Text(""),
        ],
      ),
    );
  }

  Widget accCard(String txt) {
    return Card(
      child: ListTile(
        onTap: () {
          controller.onTileTapped(txt);
        },
        tileColor: secondaryC,
        leading: contactI,
        // tileColocr: Colors.red,
        title: Text(
          txt,
          style: appbarStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: iconGreen,
        ),
      ),
    );
  }
}
