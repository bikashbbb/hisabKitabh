import 'dart:async';
import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/buttons/expandedtile.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/commonWidgets/homescreens.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:app/screens/dataentry/controller/firebase.dart';
import 'package:app/screens/dataentry/controller/itemcatcon.dart';
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

// aja k k vaune?? finish , total amount,update pani
// have only 15 items rendered at first ...
// update pani lets doo it !!
class AllTransactions extends StatefulWidget {
  final String accName;
  final bool isdaily;
  final bool isSalesAcc;
  double? amount;
  bool isOffline;
  int? totalEntries;

  static final ScrollController scrollController = ScrollController();

  static late ValueNotifier<double> _amount;

  static void upateAmount(double input) {
    _amount.value = input;
  }

  AllTransactions(this.isSalesAcc,
      {Key? key,
      required this.accName,
      required this.isdaily,
      required this.isOffline,
      this.amount,
      required this.totalEntries})
      : super(key: key) {
    if (!isOffline) _amount = ValueNotifier(amount!);
  }

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  late Future _futureList;
  ItemCatControlls? _controller;
  final Map _idIndex = {};
  //ScrollController _scrollController = ScrollController();
  /// initstate is an initializer function its called before build therefore we dont see any , null error in this case
  @override
  void initState() {
    //if (widget.isOffline) {

    _controller = Get.put(ItemCatControlls(widget.isdaily, widget.accName,
        totalEntries: widget.totalEntries!));
    /* _controller = Get.find<EntryControlls>();
    _controller!.boxName = widget.accName; */
    //if (widget.isOffline) {
    _futureList = _controller!.setObjects();
    //}
    //}
    super.initState();
  }

  void _amountBuilder() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _controller!.getTotalAmount());
  }

  @override
  Widget build(BuildContext context) {
    FireItemCat obj = FireItemCat(widget.accName);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //extendBodyBehindAppBar: true,
      backgroundColor: iconwhite,
      bottomNavigationBar: widget.isOffline
          ? Obx(() => ItemCatNavbar(widget.isSalesAcc,
              totalAmount: _controller!.accTotalAmount.value,
              isdaily: widget.isdaily,
              isOffline: widget.isOffline,
              accName: widget.accName,
              addButton: _addButton()))
          : ValueListenableBuilder<double>(
              valueListenable: AllTransactions._amount,
              builder: (context, value, child) {
                return ItemCatNavbar(
                  widget.isSalesAcc,
                  totalAmount: value,
                  addButton: _addButton(),
                  isdaily: widget.isdaily,
                  isOffline: widget.isOffline,
                  accName: widget.accName,
                );
              }),
      appBar: AppBar(
        leadingWidth: 30,
        backgroundColor: secondaryC,
        iconTheme: IconThemeData(color: iconGreen),
        systemOverlayStyle: appStyle,
        /* leading: BackButton(
          onPressed: () {
            Get.to(const HisabKitabHome());
            //DataScreen.pageController.jumpTo(1);
          },
        ), */
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
        actions: [selectButon(_controller!)],
      ),
      // HAVE A NAVIGATION BAR ALSO
      // yeha euta stream builder chainxaa !!
      body: widget.isOffline
          ? _offlineCOl()
          // online
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
                        // yeha nahi diff hanna parchaw
                        if (snaps.get("totalAmount") < 0) {
                          // online ko lagi halka farak code hunxa
                          SettleMent sobj =
                              SettleMent.fromJson(snaps, isSnaps: true);
                          return Row(
                            children: [
                              Obx(
                                () => _controller!.isSelectTap.value
                                    ? CustomCheckBox(
                                        uniqueId: id,
                                        controller: _controller,
                                        index: _idIndex[id],
                                        tapped: _controller!
                                            .isItSelected(_idIndex[id]),
                                        iSselectTap:
                                            _controller!.isSelectTap.value,
                                        totalAmount: sobj.totalAmount,
                                      )
                                    : const SizedBox(),
                              ),
                              Expanded(
                                child: SettleCard(
                                    sobj,
                                    _controller!.onCheckBoxTapped,
                                    _idIndex[id]),
                              ),
                            ],
                          );
                        }
                        return Obx((() => InfoTile(
                            Transaction.fromJson(snaps, isSnaps: true, id: id),
                            _idIndex[id],
                            iSselectTap: _controller!.isSelectTap.value,
                            controller: _controller,
                            isSales: widget.isSalesAcc,
                            haveCheckbox: true)));
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
          RollSwitcherControlls.isSale = !widget.isSalesAcc;
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
          GetBuilder<ItemCatControlls>(
              init: _controller,
              builder: (context) {
                return Text(
                  "tot".tr +
                      "ent".tr +
                      " : " +
                      _controller!.totalEntries.toString(),
                  style: subTitle,
                );
              }),
          DeleteNunSelect(
            _controller!,
            isHome: false,
          )
        ],
      );

  Widget _offlineCOl() => FutureBuilder(
      future: _futureList,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          //  then loop hanne yeha
          _amountBuilder();
          _controller!.getAllEntry();
          return GetBuilder<ItemCatControlls>(
              init: _controller,
              builder: (c) {
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
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
                            _controller!,
                          )
                        ],
                      ),
                    ),
                    // if its online have a stream builder else,a Listview builder.
                    Obx(
                      () => Expanded(
                        child: NotificationListener<ScrollUpdateNotification>(
                          child: ListView.builder(
                              controller: AllTransactions.scrollController,
                              itemCount: _controller!.allEntry.length,
                              itemBuilder: (ctx, i) {
                                return GetBuilder<ItemCatControlls>(
                                  init: _controller,
                                  builder: (builder) {
                                    if (_controller!.allEntry[i].runtimeType ==
                                        Transaction) {
                                      return _controller!.isItDeleted(i)
                                          ? const SizedBox()
                                          : Obx(() => InfoTile(
                                                _controller!.allEntry[i],
                                                i,
                                                isSales: widget.isSalesAcc,
                                                haveCheckbox: true,
                                                iSselectTap: _controller!
                                                    .isSelectTap.value,
                                                controller: _controller,
                                              ));
                                    }

                                    return _controller!.isItDeleted(i)
                                        ? const SizedBox()
                                        : Row(
                                            // <<<<<<<<<<<<<<<<<< OFFLINE >>>>>>>>>>>>>>>>>>>>..
                                            children: [
                                              Obx(
                                                () => _controller!
                                                        .isSelectTap.value
                                                    ? CustomCheckBox(
                                                        uniqueId: _controller!
                                                            .allEntry[i]
                                                            .uniqueId,
                                                        controller: _controller,
                                                        index: i,
                                                        iSselectTap:
                                                            _controller!
                                                                .isSelectTap
                                                                .value,
                                                        tapped: _controller!
                                                            .isItSelected(i),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              Expanded(
                                                child: SettleCard(
                                                    _controller!.allEntry[i],
                                                    _controller!
                                                        .onCheckBoxTapped,
                                                    i),
                                              ),
                                            ],
                                          );
                                  },
                                );
                              }),
                          onNotification: (not) {
                            if (AllTransactions.scrollController.position
                                    .maxScrollExtent ==
                                AllTransactions
                                    .scrollController.position.pixels) {
                              _controller!.getAllEntry();
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
      });
}
