import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class InfoTile extends StatelessWidget {
  late int index;
  final Transaction obj;
  InfoTile(this.obj, this.index, {Key? key}) : super(key: key);

  static String toTString(double? input) {
    if (input == null) {
      return 0.0.toString();
    }
    return input.toString();
  }

  final Icon moneyI = Icon(
    Icons.monetization_on_outlined,
    color: iconGreen,
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
      child: Container(
        height: 53.h,
        decoration: entryButton,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  " $index .",
                  style: subTitle,
                ),
                Icon(
                  Icons.account_circle_outlined,
                  color: black,
                  size: 25,
                ),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    obj.accName!,
                    style: inputStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Expanded(child: Text("")),
                Text(
                  obj.createdDate!,
                  style: subTitle,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100.w,
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
                      moneyI,
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
                      moneyI,
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
    );
  }
}
