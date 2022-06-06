import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/controller/firebase.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

// i should be addidng up the firebase stream here ...
class DataScreen extends StatefulWidget {
  final bool isDaily;
  static PageController pageController = PageController();
  static final ScrollController sControllerOn = ScrollController();
  static final ScrollController sControllerOff = ScrollController();

  const DataScreen({Key? key, this.isDaily = true}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  late EntryControlls c;

  @override
  void initState() {
    Get.delete<EntryControlls>();
    c = c = Get.put(EntryControlls(widget.isDaily, boxName: "", auto: true));
    c.getAccData;
    super.initState();
  }

  /* final GlobalKey<AnimatedListState> _accListKey =
      GlobalKey<AnimatedListState>(); */
  @override
  Widget build(BuildContext context) {
//Get.reload<EntryControlls>();
    return Scaffold(
      bottomNavigationBar:
          const SizedBox(height: 33, child: UpperNavigationBar()),
      floatingActionButton: InkWell(
          onTap: () {
            Get.to(
              CreateEntry(
                "add".tr,
                isDaily: widget.isDaily,
              ),
            );
          },
          child: secAddButton()),
      backgroundColor: iconwhite,
      body: PageView(
          controller: DataScreen.pageController,
          onPageChanged: UpperNavigationBar.changePage,
          children: [
            _pageViewWidgets(false),
            SingleChildScrollView(child: _pageViewWidgets(true))
          ]),
    );
  }

  // have a field for total amount
  Widget _accCard(AccountInfos obj) {
    return SizedBox(
      height: 69,
      child: Card(
        child: ListTile(
          onTap: () {
            c.onTileTapped(obj.accName!, widget.isDaily, obj.isSale!,
                obj.totalAmnt, obj.totalEntry);
          },
          tileColor: secondaryC,
          minLeadingWidth: 10,
          leading: contactI,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  obj.accName!,
                  style: appbarStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              salesIcon(obj.isSale!)
            ],
          ),
          subtitle: (obj.totalAmnt != null)
              ? Text(
                  obj.totalAmnt.toString(),
                  style: subTitle,
                )
              : null,
          trailing: Icon(
            Icons.arrow_right,
            color: black,
          ),
        ),
      ),
    );
  }

  Widget _pageViewWidgets(bool isOffline) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // this is offline
        _offlineTotals(),
        Divider(
          color: black,
          thickness: 1,
          height: 5.h,
        ),
        isOffline ? _offlineColumn() : _onlineColumn(),
      ],
    );
  }

  Widget _offlineTotals() {
    return Row(
      children: [
        Text(
          "tacc".tr,
          style: headerS(Colors.black54),
        ),
        /* Text(
          c.allAccounts.length.toString(),
          style: headerS(Colors.black),
        ), */
        Icon(
          Icons.swipe_down_alt_rounded,
          color: red,
        ),
        DeleteNunSelect(
          c,
        ),
        const Text("                "),
        selectButon(c, isHome: true)
      ],
    );
  }

  Widget _offlineColumn() {
    return Obx(
      () => SizedBox(
        child: ListView.builder(
            key: const PageStorageKey(1),
            controller: DataScreen.sControllerOff,
            shrinkWrap: true,
            //key: _accListKey,
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
                      tapped: c.isItSelected(
                        i,
                      ),
                    ),
                  ),
                  //
                  //
                  Expanded(
                      child: _accCard(AccountInfos(
                          isSale: c.checkIsSales(accname)!, accName: accname))),
                ],
              );
            }),
      ),
    );
  }

  Widget _onlineColumn() {
    int i = 0;
    return Expanded(
      child: FirestoreListView(
        controller: DataScreen.sControllerOn,
        shrinkWrap: true,
        key: const PageStorageKey(0),
        query: FireHomePage(widget.isDaily).getAccountQuery(),
        itemBuilder: (ctx, snapshot) {
          //Map v = snapshot.data();
          //return SizedBox();
          // just add up the delete
          int index = i++;
          return Row(
            children: [
              Obx(() => CustomCheckBox(
                    isHome: true,
                    controller: c,
                    index: index,
                    iSselectTap: c.isSelectTapHome.value,
                    uniqueId: snapshot.id,
                    tapped: c.isItSelected(
                      index,
                    ),
                  )),
              Expanded(child: _accCard(AccountInfos.fromJson(snapshot))),
            ],
          );
        },
      ),
    );
  }
}
