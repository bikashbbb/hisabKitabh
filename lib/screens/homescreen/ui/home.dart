import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HisabKitabHome extends StatelessWidget {
  const HisabKitabHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 0,
      ),
      //  we will have a custom unique appbar...
      bottomNavigationBar: SizedBox(height: 90.h, child: BottomNav()),
      // just change the body of home
    );
  }
}
