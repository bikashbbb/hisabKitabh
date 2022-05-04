import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/homescreens.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/commonWidgets/iconboard.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/controller/homescreenc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// user put in daily entries here ,daily cash entry !!
class DailyEntryPage extends StatefulWidget {
  final bool isdaily;
  const DailyEntryPage(this.isdaily, {Key? key}) : super(key: key);

  @override
  State<DailyEntryPage> createState() => _DailyEntryPageState();
}

class _DailyEntryPageState extends State<DailyEntryPage> {
  late HomeControllerInterface _controlls;

  @override
  void initState() {
    Get.delete<HomeControllerInterface>();
    Get.delete<EntryControlls>();
    _controlls = HomeControllerInterface(widget.isdaily);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: iconGreen,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 700.h,
          decoration: homeDecoration,
          child: GetBuilder<HomeControllerInterface>(
              init: _controlls,
              builder: (b) {
                // here also have a fucking stream ! and a good condition...
                return b.doesAccExists()
                    ? DataScreen(
                        isDaily: widget.isdaily,
                      )
                    : _entryFirst();
              }),
        ));
  }

  Widget _entryFirst() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 40.w),
          child: IconBoard(
            imagePath: widget.isdaily
                ? 'assets/images/bookwriting.png'
                : 'assets/images/borrow.png',
            iconCOlor: widget.isdaily ? iconGreen : null,
          ),
        ),
        helptext(widget.isdaily ? "goal2".tr : "goal3".tr),
        SizedBox(
          height: 29.h,
        ),
        dailyButton(widget.isdaily)
      ],
    );
  }
}
