import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

String initialitem = "plate";
List<String> itemlist = ["Kg", "gram", "Litre", "Item", "plate"];
List<String> allfilenames = ["record datas", "personal", ""];

String fontName = "customfont";
Icon handI = const Icon(
  Icons.pan_tool_outlined,
  size: 20,
);
Icon contactI = Icon(
  Icons.contact_page,
  size: 30,
  color: black,
);

Widget select = Text(
  "s".tr,
  style: headerS(Colors.black),
);
