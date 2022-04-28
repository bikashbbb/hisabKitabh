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
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:flutter/material.dart';
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
  final String navName;
  final bool isdaily;
  final bool isSalesAcc;

  const AllTransactions(this.isSalesAcc,
      {Key? key,
      required this.accName,
      this.navName = "",
      required this.isdaily})
      : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  final ScrollController _scrollController = ScrollController();
  late Future<bool> _futureList;
  EntryControlls? _controller;

  /// initstate is an initializer function its called before build therefore we dont see any , null error in this case
  @override
  void initState() {
    _controller = Get.put(EntryControlls(boxName: widget.accName));
    _futureList = _controller!.setObjects();
    super.initState();
  }

  void _amountBuilder() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _controller!.getTotalAmount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iconwhite,
      bottomNavigationBar: Obx(() => ItemCatNavbar(widget.isSalesAcc,
          totalAmount: _controller!.accTotalAmount.value,
          addButton: _addButton())),
      appBar: AppBar(
        leadingWidth: 30,
        leading: BackButton(
          onPressed: () {
            Get.delete<EntryControlls>();
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
        actions: [selectButon(_controller!)],
      ),
      // HAVE A NAVIGATION BAR ALSO
      body: FutureBuilder(
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
                            child:
                                NotificationListener<ScrollUpdateNotification>(
                              child: ListView.builder(
                                  controller: _scrollController,
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
                                                  haveCheckbox: true,
                                                  db: _controller!.selectedItem,
                                                  iSselectTap: _controller!
                                                      .isSelectTap.value,
                                                  controller: _controller,
                                                ));
                                      },
                                    );
                                  }),
                              onNotification: (not) {
                                if (_scrollController
                                        .position.maxScrollExtent ==
                                    _scrollController.position.pixels) {
                                  _controller!.getAllEntry(isScrolling: true);
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
          }),
    );
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
}
