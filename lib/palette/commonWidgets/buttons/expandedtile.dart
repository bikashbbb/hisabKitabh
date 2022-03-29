import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// complete it today and curve container
class CustomTile extends StatefulWidget {
  CustomTile(
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
  double nonExpandedHeight;

  /// width when tile is not opened
  double nonExpandedWidth;

  /// height of the expanded body
  double expansionHeight;

  /// non expanded color, default to green
  Color? nonExpandedcolor;

  /// tilte widget to display at the head before expansion
  final Widget? title;

  /// state of the tile
  bool isExpanded;

  /// a icon to display after the title
  IconData trailingicon;

  /// body of the expanded tile , i.e Column
  Widget? body;

  /// a widget before a title widget
  Widget? leding;

  /// title disapper on click
  bool onclikDisapper;

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
  final Transaction object;
  InfoTile(this.object, {Key? key}) : super(key: key);

  final Icon moneyI = Icon(
    Icons.monetization_on_outlined,
    color: iconGreen,
    size: 22,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: secondaryC,
      height: 53.h,
      // border
      decoration: entryButton,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle_outlined,
                color: black,
                size: 25,
              ),
              SizedBox(
                width: 260.w,
                child: Text(
                  "Account name",
                  style: inputStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Expanded(child: Text("")),
              Text(
                "2022/03/30",
                style: subTitle,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120.w,
                child: Text(
                  "onion",
                  style: subTitle,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "2kg X ",
                      style: subTitle,
                    ),
                    moneyI,
                    Text(
                      "200",
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
                      "",
                      style: subTitle,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
