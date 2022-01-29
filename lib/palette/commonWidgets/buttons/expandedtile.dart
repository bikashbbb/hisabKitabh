import 'package:app/palette/styles/colors.dart';
import 'package:flutter/material.dart';
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
      this.leding})
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
  Widget? title;

  /// state of the tile
  bool isExpanded;

  /// a icon to display after the title
  IconData trailingicon;

  /// body of the expanded tile , i.e Column
  Widget? body;

  /// a widget before a title widget
  Widget? leding;

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
            color: widget.nonExpandedcolor,
            height: widget.nonExpandedHeight,
            width: widget.nonExpandedWidth,
            child: Row(
              children: [
                Expanded(child: widget.title!),
                Icon(
                  widget.trailingicon,
                )
              ],
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: istileopen,
          builder: (context, value, child) => istileopen.value
              ? Container(
                  height: widget.expansionHeight,
                  color: iconGreen,
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
