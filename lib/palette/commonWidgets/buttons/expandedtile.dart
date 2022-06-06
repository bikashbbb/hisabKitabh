import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/controller/itemcatcon.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// okey f the item name is too long when clicked on it tyo expand hunxa to show the item name !! yes yes
// complete it today and curve container
class CustomTile extends StatefulWidget {
  const CustomTile(
      {Key? key,
      this.nonExpandedHeight = 30,
      this.nonExpandedWidth = 200,
      this.expansionHeight = 100,
      this.isExpanded = false,
      this.trailingicon = Icons.arrow_drop_down,
      //required this.body,
      required this.title,
      this.nonExpandedcolor,
      this.leding,
      this.onclikDisapper = false,
      this.body})
      : super(key: key);

  /// height when tile is not opened
  final double nonExpandedHeight;

  /// width when tile is not opened
  final double nonExpandedWidth;

  /// height of the expanded body
  final double expansionHeight;

  /// non expanded color, default to green
  final Color? nonExpandedcolor;

  /// tilte widget to display at the head before expansion
  final Widget? title;

  /// state of the tile
  final bool isExpanded;

  /// a icon to display after the title
  final IconData trailingicon;

  /// body of the expanded tile , i.e Column
  final Widget? body;

  /// a widget before a title widget
  final Widget? leding;

  /// title disapper on click
  final bool onclikDisapper;

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  /// if tile is open or not
  ValueNotifier<bool> istileopen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: _opentheBody,
          child: Container(
            decoration: entryButton,
            color: widget.nonExpandedcolor,
            height: widget.nonExpandedHeight,
            width: widget.nonExpandedWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: widget.title!),
                Icon(
                  widget.trailingicon,
                  color: iconGreen,
                )
              ],
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: istileopen,
          builder: (context, value, child) => istileopen.value
              ? SizedBox(
                  height: widget.expansionHeight,
                  child: widget.body,
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  void _opentheBody() {
    istileopen.value = !istileopen.value;
  }
}

// ignore: must_be_immutable
class InfoTile extends StatelessWidget {
  int index;
  final Transaction obj;
  final bool iSselectTap, isSales, haveCheckbox;
  final dynamic controller;
  // afnai tile ho yo muji kati wota render vayo ma track rakhxu muji
  InfoTile(
    this.obj,
    this.index, {
    Key? key,
    this.iSselectTap = false,
    this.controller,
    required this.isSales,
    required this.haveCheckbox,
  }) : super(key: key);

  static String toTString(double? input) {
    if (input == null) {
      return 0.0.toString();
    }
    return input.toString();
  }

  static Icon moneyI(Color color) => Icon(
        Icons.monetization_on_outlined,
        color: color,
        size: 22,
      );

  @override
  Widget build(BuildContext context) {
    index += 1;
    String tQuantity = toTString(obj.totalQuantit);
    String price = toTString(obj.perQuantityPrice);
    String amnt = toTString(obj.totalAmount);

    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          haveCheckbox
              ? Obx(() => CustomCheckBox(
                    controller: controller!,
                    index: index,
                    uniqueId: obj.uniqueId!,
                    iSselectTap: iSselectTap,
                    tapped: controller.isItSelected(index),
                  ))
              : const SizedBox(),
          Flexible(
            child: InkWell(
              onTap: () {
                iSselectTap
                    ? controller!.onCheckBoxTapped(
                        index,
                        obj.uniqueId!,
                      )
                    : null;
              },
              child: Container(
                height: 53.h,
                decoration: entryButton,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          " $index.",
                          style: subTitle,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          color: black,
                          size: 25,
                        ),
                        salesIcon(isSales, size: 20),
                        SizedBox(
                          width: iSselectTap ? 239.w : 248.w,
                          child: Text(
                            obj.accName!,
                            style: inputStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const Expanded(child: Text("")),
                        Text(
                          Calender.dateFormatter(obj.createdDate),
                          style: subTitle,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            obj.itemname,
                            style: subTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                tQuantity + " " + obj.quantityType + " X ",
                                style: subTitle,
                              ),
                              moneyI(iconGreen),
                              Text(
                                price,
                                style: inputStyle,
                              )
                            ],
                          ),
                        ),
                        Text(
                          "=",
                          style: subTitle,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              moneyI(iconGreen),
                              Text(
                                amnt,
                                style: inputStyle,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettleCard extends StatelessWidget {
  final SettleMent obj;
  const SettleCard(this.obj, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: ListTile(
        tileColor: obj.isSale ? red : iconGreen,
        title: Row(
          children: [
            const Icon(Icons.arrow_right_alt_outlined),
            Text(
              obj.isSale ? 'Rceved'.tr : "Gvn".tr,
              style: appbarStyle,
            ),
            const Expanded(child: Text("")),
            Text(
              Calender.dateFormatter(obj.createdDate),
              style: subTitle,
            )
          ],
        ),
        subtitle: Row(
          children: [
            InfoTile.moneyI(obj.isSale ? iconGreen : Colors.white),
            Text(
              obj.totalAmount.toString(),
              style: small16,
            ),
          ],
        ),
      ),
    );
  }
}
