import 'dart:async';
import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/buttons/expandedtile.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/controller/firebase.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

// aja k k vaune?? finish , total amount,update pani
// have only 15 items rendered at first ...
// update pani lets doo it !!
class AllTransactions extends StatefulWidget {
  final String accName;
  final bool isdaily;
  final bool? isSalesAcc;
  double? amount;
  bool isOffline;
  int? totalEntries;

  static final ScrollController scrollController = ScrollController();

  static late ValueNotifier<double> _amount;

  static void upateAmount() {}

  AllTransactions(this.isSalesAcc,
      {Key? key,
      required this.accName,
      required this.isdaily,
      required this.isOffline,
      this.amount,
      this.totalEntries})
      : super(key: key) {
    _amount = ValueNotifier(amount!);
  }

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  late Future<bool> _futureList;
  EntryControlls? _controller;
  Map _idIndex = {};
  //ScrollController _scrollController = ScrollController();
  /// initstate is an initializer function its called before build therefore we dont see any , null error in this case
  @override
  void initState() {
    widget.isOffline = false;

    if (widget.isOffline) {
      _controller =
          Get.put(EntryControlls(widget.isdaily, boxName: widget.accName));
      _futureList = _controller!.setObjects();
    }
    super.initState();
  }

  void _amountBuilder() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _controller!.getTotalAmount());
  }

  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FireItemCat obj = FireItemCat(widget.accName);
    return Scaffold(
      backgroundColor: iconwhite,
      bottomNavigationBar: widget.isOffline
          ? Obx(() => ItemCatNavbar(widget.isSalesAcc!,
              totalAmount: _controller!.accTotalAmount.value,
              addButton: _addButton()))
          : ValueListenableBuilder<double>(
              valueListenable: AllTransactions._amount,
              builder: (context, value, child) {
                return ItemCatNavbar(widget.isSalesAcc!,
                    totalAmount: value, addButton: _addButton());
              }),
      appBar: AppBar(
        leadingWidth: 30,
        leading: BackButton(
          onPressed: () {
            // _controller!.onDisposeBox();
            //Get.delete<EntryControlls>();
            Get.back();
          },
        ),
        backgroundColor: secondaryC,
        iconTheme: IconThemeData(color: iconGreen),
        systemOverlayStyle: appStyle,
        title: Row(
          children: [
            contactI,
            SizedBox(
              width: 220.w,
              child: Text(
                widget.accName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: appbarStyle,
              ),
            ),
          ],
        ),
        /* actions: [
            
            selectButon(_controller!)], */
      ),
      // HAVE A NAVIGATION BAR ALSO
      // yeha euta stream builder chainxaa !!
      body: widget.isOffline
          ? FutureBuilder(
              future: _futureList,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  //  then loop hanne yeha
                  _amountBuilder();
                  _controller!.getAllEntry();
                  return GetBuilder<EntryControlls>(
                      init: _controller,
                      builder: (c) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "tot".tr +
                                      "ent".tr +
                                      " : " +
                                      _controller!.entryTotal.toString(),
                                  style: subTitle,
                                ),
                                DeleteNunSelect(
                                  _controller!.selectedItem,
                                  isHome: false,
                                )
                              ],
                            ),
                            // if its online have a stream builder else,a Listview builder.
                            Obx(
                              () => Expanded(
                                child: NotificationListener<
                                    ScrollUpdateNotification>(
                                  child: ListView.builder(
                                      controller:
                                          AllTransactions.scrollController,
                                      itemCount: _controller!.allEntry.length,
                                      itemBuilder: (ctx, i) {
                                        return GetBuilder<EntryControlls>(
                                          init: _controller,
                                          builder: (builder) {
                                            return _controller!.isItDeleted(i)
                                                ? const SizedBox()
                                                : Obx(() => InfoTile(
                                                      _controller!.allEntry[i],
                                                      i,
                                                      isSales: c.checkIsSales(
                                                          widget.accName)!,
                                                      haveCheckbox: true,
                                                      db: _controller!
                                                          .selectedItem,
                                                      iSselectTap: _controller!
                                                          .isSelectTap.value,
                                                      controller: _controller,
                                                    ));
                                          },
                                        );
                                      }),
                                  onNotification: (not) {
                                    if (AllTransactions.scrollController
                                            .position.maxScrollExtent ==
                                        AllTransactions
                                            .scrollController.position.pixels) {
                                      _controller!
                                          .getAllEntry(isScrolling: true);
                                    }
                                    return true;
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                      });
                } else {
                  // loader run garne until !!
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
          : Column(
              children: [
                _online(),
                Expanded(
                  // 10
                  child: FirestoreListView(
                      pageSize: 15,
                      query: obj.getEntryQuery(),
                      itemBuilder: (ctx, snaps) {
                        String id = snaps.id;
                        _idValidator(id);
                        // the index ladow !/snaps.data();
                        // how do i fucking give the index ladow !
                        return InfoTile(
                            Transaction.fromJson(snaps, isSnaps: true),
                            _idIndex[id],
                            isSales: widget.isSalesAcc!,
                            haveCheckbox: false);
                      }),
                ),
              ],
            ),
    );
  }

  void _idValidator(String id) {
    if (!_idIndex.containsKey(id)) {
      _idIndex[id] = _idIndex.length;
    }
  }

  Widget _addButton() {
    return InkWell(
        onTap: () {
          accountName.text = widget.accName;
          RollSwitcherControlls.isSale = !widget.isSalesAcc!;
          Get.to(
            () => CreateEntry(
              "add".tr,
              isPreviousAcc: true,
            ),
          );
        },
        child: secAddButton());
  }

  Widget _online() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "tot".tr + "ent".tr + " : " + widget.totalEntries.toString(),
            style: subTitle,
          ),
          /* DeleteNunSelect(
            _controller!.selectedItem,
            isHome: false,
          ) */
        ],
      );
}
