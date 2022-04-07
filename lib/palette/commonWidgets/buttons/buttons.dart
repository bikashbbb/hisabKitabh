import 'dart:async';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants/dropdowncons.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

Widget loginButoon(String title, String bName) => Container(
      alignment: Alignment.center,
      height: 40.h,
      width: bName == "L" ? 85.w : 60.w,
      child: Text(
        title,
        style: white15,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: bName == "L" ? Colors.white : Colors.red),
        color: Colors.black.withOpacity(0.7),
      ),
    );

Widget dailyEntryButton() {
  return Container(
    width: 200.w,
    height: 60.h,
    decoration: entryButton,
    alignment: Alignment.center,
    child: Text(
      "entryb".tr,
      style: TextStyle(
          color: darkBlack, fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  );
}

class AddButton extends StatefulWidget {
  final String text;
  const AddButton(this.text, {Key? key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool isAnimated = false;
  late Timer time;
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    time.cancel();
  }

  void startAnimation() {
    time = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60.h,
      width: 60.w,
      decoration: circleblackDec,
      child: AnimatedDefaultTextStyle(
        onEnd: () {
          setState(() {
            isAnimated = !isAnimated;
          });
        },
        style: TextStyle(
          fontSize: isAnimated ? 50.sp : 40.sp,
        ),
        duration: const Duration(seconds: 1),
        child: Text(widget.text, style: addbuttonStyle),
      ),
    );
  }
}

class DropDownButton extends StatefulWidget {
  static Icon checkicon = Icon(
    Icons.check_circle_outline,
    size: 15,
    color: Colors.green[900],
  );
  final List<String> dropdownItems;
  const DropDownButton(this.dropdownItems, {Key? key}) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 60.w,
      decoration: entryButton,
      child: DropdownButton(
          elevation: 0,
          iconSize: 14.w,
          iconEnabledColor: Colors.black,
          isExpanded: true,
          borderRadius: BorderRadius.circular(13.0),
          dropdownColor: Colors.black87,
          hint: Text(
            "  " + initialitem,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold),
          ),
          items: widget.dropdownItems.map(
            (val) {
              return DropdownMenuItem<String>(
                  value: val,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        val,
                        style: optionalstyles(Colors.white),
                      ),
                      initialitem == val
                          ? DropDownButton.checkicon
                          : const SizedBox()
                    ],
                  ));
            },
          ).toList(),
          onChanged: changeHintText),
    );
  }

  void changeHintText(Object? change) {
    setState(() {
      initialitem = change.toString();
    });
  }
}

class Calender extends StatefulWidget {
  static String dateFormatter(DateTime input) {
    return "${input.year}-${input.month}-${input.day}";
  }

  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  dynamic initaldate = DateTime.now();
  bool isAd = true;
  @override
  void initState() {
    super.initState();
    nowdate = Calender.dateFormatter(initaldate);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 193.w,
      child: Row(
        children: [
          dateIcon,
          InkWell(
            onTap: () async {
              DateTime? selected = await onDateClicked(context);
              if (selected != null) {
                setState(() {
                  initaldate = selected;
                  nowdate = Calender.dateFormatter(selected);
                });
              }
            },
            child: Container(
                height: 33.h,
                width: 110.w,
                decoration: entryButton,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    nowdate!,
                    style: optionred,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: black,
                  ),
                ])),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: bsOrAd(),
          )
        ],
      ),
    );
  }

  Widget bsOrAd() {
    return SizedBox(
        width: 42.w,
        height: 50.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onAdBsTapped,
              child: Row(
                children: [
                  Text(
                    "A.D".tr,
                    style: optionblack,
                  ),
                  isAd ? DropDownButton.checkicon : const SizedBox()
                ],
              ),
            ),
            Divider(
              height: 2.h,
              color: Colors.black,
            ),
            InkWell(
              onTap: onAdBsTapped,
              child: Row(
                children: [
                  Text(
                    "B.S".tr,
                    style: optionblack,
                  ),
                  !isAd ? DropDownButton.checkicon : const SizedBox()
                ],
              ),
            ),
          ],
        ));
  }

  onDateClicked(BuildContext context) async {
    return isAd
        ? await showDatePicker(
            builder: (BuildContext context, Widget? child) => Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.dark(
                    primary: iconGreen,
                    onPrimary: Colors.white,
                    surface: iconGreen,
                    onSurface: Colors.yellow,
                  ),
                ),
                child: child!),
            confirmText: "DONE",
            context: context,
            initialDate: initaldate,
            firstDate: DateTime(2018, 3, 5),
            lastDate: DateTime(2022, 6, 7))
        : picker.showMaterialDatePicker(
            context: context,
            initialDate: initaldate,
            firstDate: picker.NepaliDateTime(2075, 01, 09),
            lastDate: picker.NepaliDateTime(2090));
  }

  void onAdBsTapped() {
    isAd = !isAd;
    if (isAd) {
      initaldate = DateTime.now();
      nowdate = Calender.dateFormatter(initaldate);
    } else {
      initaldate = picker.NepaliDateTime.now();
      nowdate = Calender.dateFormatter(initaldate);
    }
    setState(() {});
  }
}

Widget clearBUtton(String title, onpressed) {
  return SizedBox(
    height: 45.h,
    width: 45.w,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.red[100], shape: const CircleBorder(), elevation: 15),
      onPressed: onpressed,
      child: Text(
        title,
        style: optionred,
      ),
    ),
  );
}

Widget dailyButton = TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.black12),
    ),
    onPressed: () {
      Get.off(
        () => CreateEntry(
          "add".tr,
        ),
      );
    },
    child: dailyEntryButton());
