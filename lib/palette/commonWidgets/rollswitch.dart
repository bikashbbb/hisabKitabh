import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:rolling_switch/rolling_switch.dart';

class RollSwitcher extends StatelessWidget {
  const RollSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 4.w),
      child: SizedBox(
        width: 175.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("acctype2".tr, style: helpTextStyle),
            rollswitecher(),
            Text("acctype".tr, style: helpTextStyle),
          ],
        ),
      ),
    );
  }

  static Widget rollswitecher() {
    return RollingSwitch.icon(
      width: 80.w,
      onChanged: (bool state) {},
      rollingInfoRight: const RollingIconInfo(
          icon: Icons.arrow_right, backgroundColor: Colors.red),
      rollingInfoLeft: const RollingIconInfo(
        icon: Icons.arrow_left,
        backgroundColor: Colors.green,
      ),
    );
  }
}
