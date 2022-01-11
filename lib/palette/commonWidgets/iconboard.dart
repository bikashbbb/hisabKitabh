import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBoard extends StatelessWidget {
  final String imagePath;
  const IconBoard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40.w, top: 80.h),
      child: SizedBox(
        height: 300.h,
        width: 300.w,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 220.h,
              width: 280.w,
            ),
            Image.asset(
              'assets/images/noun-curved-arrow-3067940-2.png',
              height: 60.h,
              color: Colors.red[200],
            )
          ],
        ),
      ),
    );
  }
}
