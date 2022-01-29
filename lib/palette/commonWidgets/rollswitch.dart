import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RollSwitcher extends StatefulWidget {
  const RollSwitcher({Key? key}) : super(key: key);

  @override
  State<RollSwitcher> createState() => _RollSwitcherState();
}

class _RollSwitcherState extends State<RollSwitcher> {
  final RollSwitcherControlls controlls = Get.find();
  bool ist = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 4.w),
      child: SizedBox(
        width: 210.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("acctype2".tr, style: helpTextStyle),
            SizedBox(
              child: CupertinoSwitch(
                  activeColor: Colors.red,
                  trackColor: Colors.green,
                  value: ist,
                  onChanged: onChnaged),
            ), // SizedBox(height: 50.h, width: 100.w, child: rollswitecher()),
            Text("acctype".tr, style: helpTextStyle),
          ],
        ),
      ),
    );
  }

  void onChnaged(bool change) {
    setState(() {
      ist = change;
    });
    controlls.rollSwitched(change);
  }
}
