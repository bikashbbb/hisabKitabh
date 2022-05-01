import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// add hanne pachi add it up only if the count is less than 14 or wise just add up the amount!,total entry thats it !!
// amount ra total entry animate garera add garnee !
class RollSwitcher extends StatefulWidget {
  final String accOne;
  final String accTwo;
  const RollSwitcher(this.accOne,this.accTwo,{Key? key}) : super(key: key);

  @override
  State<RollSwitcher> createState() => _RollSwitcherState();
}

class _RollSwitcherState extends State<RollSwitcher> {
  final RollSwitcherControlls controlls = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 4.w),
      child: SizedBox(
        width: 210.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.accOne, style: helpTextStyle),
            SizedBox(
              child: CupertinoSwitch(
                  activeColor: Colors.red,
                  trackColor: Colors.green,
                  value: RollSwitcherControlls.isSale,
                  onChanged: onChnaged),
            ), // SizedBox(height: 50.h, width: 100.w, child: rollswitecher()),
            Text(widget.accTwo.tr, style: helpTextStyle),
          ],
        ),
      ),
    );
  }

  void onChnaged(bool change) {
    controlls.rollSwitched(change);

    setState(() {});
  }
}
