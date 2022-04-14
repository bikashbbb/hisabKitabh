import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/buttons/expandedtile.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// have only 15 items rendered at first ...
class AllTransactions extends StatelessWidget {
  final int accCode;
  final String accName;
  final String navName;
  final bool isdaily;

  AllTransactions(
      {Key? key,
      required this.accCode,
      required this.accName,
      this.navName = "",
      required this.isdaily})
      : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(EntryControlls(boxxx: isdaily ? dailyBox : lendBox));

    controller.getAllEntry(accCode);

    return Scaffold(
      floatingActionButton: secAddButton(),
      backgroundColor: iconwhite,
      appBar: AppBar(
        leadingWidth: 30,
        leading: BackButton(
          onPressed: () {
            Get.delete<EntryControlls>();
            Get.back();
          },
        ),
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
        actions: [InkWell(onTap: () {}, child: selectB)],
      ),
      // HAVE A NAVIGATION BAR ALSO
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "tot".tr +
                    "ent".tr +
                    " : " +
                    controller.o.totalLength.toString(),
                style: subTitle,
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          // if its online have a stream builder else,a Listview builder.

          Obx(
            () => Expanded(
              child: NotificationListener<ScrollUpdateNotification>(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.allEntry.length,
                    itemBuilder: (ctx, i) {
                      return InfoTile(controller.allEntry[i], i);
                    }),
                onNotification: (not) {
                  if (_scrollController.position.maxScrollExtent ==
                      _scrollController.position.pixels) {
                    controller.getAllEntry(accCode, isScrolling: true);
                  }
                  return true;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
