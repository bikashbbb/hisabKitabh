import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/buttons/expandedtile.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/const.dart';
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
class AllTransactions extends StatefulWidget {
  final int accCode;
  final String accName;
  final String navName;
  final bool isdaily;

  const AllTransactions(
      {Key? key,
      required this.accCode,
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

  @override
  void initState() {
    _controller = Get.put(EntryControlls(boxName: widget.accName));
    _futureList = _controller!.setObjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
            onTap: () {
              accountName.text = widget.accName;
              Get.off(
                () => CreateEntry(
                  "add".tr,
                ),
              );
            },
            child: secAddButton()),
        backgroundColor: iconwhite,
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
                                    c.builderTotal.toString(),
                                style: subTitle,
                              ),
                              DeleteNunSelect(
                                c.selectedItem,
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
                                    controller: _scrollController,
                                    itemCount: _controller!.allEntry.length,
                                    itemBuilder: (ctx, i) {
                                      return Obx(() => InfoTile(
                                            _controller!.allEntry[i],
                                            i,
                                            haveCheckbox: true,
                                            db: _controller!.selectedItem,
                                            iSselectTap:
                                                _controller!.isSelectTap.value,
                                            controller: _controller,
                                          ));
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
            }));
  }
}
