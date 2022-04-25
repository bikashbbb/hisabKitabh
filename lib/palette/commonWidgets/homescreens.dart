import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

class DataScreen extends StatefulWidget {
  final bool isDaily;

  const DataScreen({Key? key, this.isDaily = true}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  var c = Get.put(EntryControlls(boxName: ""));

  @override
  void initState() {
    super.initState();
    c.getAccData;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> accListKey =
        GlobalKey<AnimatedListState>();
    return Scaffold(
      floatingActionButton: dailyButton,
      backgroundColor: iconwhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              children: [
                Text(
                  "tacc".tr,
                  style: headerS(Colors.black54),
                ),
                Text(
                  c.allAccounts.length.toString(),
                  style: headerS(Colors.black),
                ),
                DeleteNunSelect(
                  c.selectedItemHOme,
                ),
                const Text("                "),
                selectButon(c, isHome: true)
              ],
            ),
          ),
          Divider(
            color: black,
            thickness: 1,
            height: 20.h,
          ),
          // lets have a list builder
          Obx(
            () => Expanded(
                child: SizedBox(
              child: ListView.builder(
                  key: accListKey,
                  itemCount: c.allAccounts.length,
                  itemBuilder: (ct, i) {
                    String accname = c.allAccounts[i];
                    return Row(
                      children: [
                        Obx(
                          () => CustomCheckBox(
                            isHome: true,
                            uniqueId: accname,
                            controller: c,
                            index: i,
                            iSselectTap: c.isSelectTapHome.value,
                          ),
                        ),
                        Expanded(child: accCard(accname, i)),
                      ],
                    );
                  }),
            )),
          ),

          const Text(""),
        ],
      ),
    );
  }

  Widget accCard(String txt, i) {
    return Card(
      child: ListTile(
        onTap: () {
          c.onTileTapped(txt, widget.isDaily);
        },
        tileColor: secondaryC,
        minLeadingWidth: 10,

        leading: contactI,
        // tileColocr: Colors.red,

        title: Text(
          txt,
          style: appbarStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: iconGreen,
        ),
      ),
    );
  }
}
