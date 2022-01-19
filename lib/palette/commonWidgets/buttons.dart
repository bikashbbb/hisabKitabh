import 'dart:async';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    width: 350.w,
    height: 60.h,
    decoration: entryButton,
    alignment: Alignment.center,
    child: Text(
      "entryb".tr,
      style: TextStyle(
          color: Colors.red[300], fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  );
}

class AddButton extends StatefulWidget {
  String text;
  AddButton(this.text, {Key? key}) : super(key: key);

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
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
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
        child: Text(
          widget.text,
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: entryButton,
    );
  }
}

class DropDownButton extends StatefulWidget {
  List<String> dropdownItems;
  DropDownButton(this.dropdownItems, {Key? key}) : super(key: key);

  static String initialitem = " Ɪ";

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  double width = 45.w;
  bool isopen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: width,
      decoration: entryButton,
      child: DropdownButton(
          iconEnabledColor: Colors.black,
          isExpanded: true,
          borderRadius: BorderRadius.circular(13.0),
          dropdownColor: Colors.black87,
          hint: Text(
            DropDownButton.initialitem,
            style: const TextStyle(color: Colors.black),
          ),
          items: widget.dropdownItems.map(
            (val) {
              return DropdownMenuItem<String>(
                  value: val,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(val),
                      Builder(builder: (builder) {
                        if (val == DropDownButton.initialitem ||
                            val == widget.dropdownItems[3] &&
                                DropDownButton.initialitem == " I") {
                          return Icon(
                            Icons.check,
                            size: 15,
                            color: Colors.green[900],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  ));
            },
          ).toList(),
          onChanged: (change) {
            changeHintText(change);
          }),
    );
  }

  void changeHintText(Object? change) {
    if (change.toString() == widget.dropdownItems[3]) {
      change = " I";
    }
    setState(() {
      DropDownButton.initialitem = change.toString();
    });
  }
}
