import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/buttons/expandedtile.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/commonWidgets/ctextfields.dart';
import 'package:app/palette/commonWidgets/icon_rounder.dart';
import 'package:app/palette/commonWidgets/rollswitch.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:app/screens/homescreen/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// this is same for two screens,just make the app bar name a variable,and identify if its editing option,
class CreateEntry extends StatefulWidget {
  final String appbarTitle;
  final bool isDaily;
  final bool isPreviousAcc;
  const CreateEntry(this.appbarTitle,
      {Key? key, this.isDaily = true, this.isPreviousAcc = false})
      : super(key: key);

  static void onBack() {
    Get.offAll(() => const HisabKitabHome());
  }

  @override
  State<CreateEntry> createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {
  final DateTime initialDate = DateTime.now();
  late CreateControlls obscontroll;

  @override
  void initState() {
    obscontroll = Get.put(CreateControlls(isDaily: widget.isDaily));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<CreateControlls>(
          init: CreateControlls(),
          builder: (context) {
            return InkWell(
                onTap: () {
                  obscontroll.onAdditem(widget.isPreviousAcc);
                },
                child: secAddButton());
          }),
      bottomNavigationBar: SizedBox(
        height: 30.h,
        //child:
      ),
      //resizeToAvoidBottomInset: true,
      backgroundColor: secondaryC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        systemOverlayStyle: appStyle,
        title: Text(
          widget.appbarTitle,
          style: appbarStyle,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: widget.isPreviousAcc
                    ? () {
                        Get.back();
                      }
                    : CreateEntry.onBack,
                child: iconRounder(
                    Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30.sp,
                    ),
                    false),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 2.h,
              color: Colors.black,
            ),
            formheader(),
            SizedBox(
              height: 13.h,
            ),
            formbody(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.summarize,
                    color: darkBlack,
                  ),
                  Text(
                    "summary".tr,
                    style: helpTextStyle,
                  ),
                ],
              ),
            ),
            formTail()
          ],
        ),
      ),
    );
  }

  Widget formheader() {
    String exp = widget.isDaily ? "eg1".tr : "eg2".tr;
    /* String accName = "";
    GetBuilder<RollSwitcherControlls>(
      init: RollSwitcherControlls(),
      builder: (con) {
        accName = RollSwitcherControlls.isSale ? 'acc3'.tr + "t".tr : "acc4".tr;
        return const SizedBox();
      },
    ); */
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      child: Container(
        alignment: Alignment(0, -0.8.h),
        width: 385.w,
        height: 70.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 170.w,
                  height: 40.h,
                  child: Obx(() => addTransactionField("acc".tr,
                      con: fieldslist[0],
                      isReq: obscontroll.reqFields[0].value,
                      len: 20)),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Obx(
                      () => obscontroll.reqFields[0].value
                          ? Text(
                              "req",
                              style: optionred,
                            )
                          : Text(
                              exp,
                              style: optionblack,
                            ),
                    ))
              ],
            ),
            GetBuilder<RollSwitcherControlls>(
                init: RollSwitcherControlls(),
                builder: (controlls) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isDaily
                          ? RollSwitcher("acctype2".tr, "acctype".tr)
                          : RollSwitcher("acc3".tr, "acc4".tr),
                      Padding(
                          padding: EdgeInsets.only(left: 31.0.w),
                          child: Text(
                            "acctypee".tr,
                            style: RollSwitcherControlls.isSale
                                ? optionred
                                : optiongreen,
                          ))
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

// add per quantity,price per quanity and SI unit in More Details Expansion tile,also bs/ad option in date
  Widget formbody(BuildContext context) {
    String textLabel1 = widget.isDaily ? "buy".tr : "Rceved".tr;
    String textLabel2 = widget.isDaily ? "sold".tr : "Gvn".tr;
    var optional = GetBuilder<RollSwitcherControlls>(
        init: RollSwitcherControlls(),
        builder: (controlls) {
          return Text(
            "option".tr,
            style: RollSwitcherControlls.isSale ? optionred : optiongreen,
          );
        });
    Widget divEr = Divider(
      height: 2.h,
      color: Colors.black45,
    );
    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 170.h),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GetBuilder<RollSwitcherControlls>(
                      init: RollSwitcherControlls(),
                      builder: (controlls) {
                        return SizedBox(
                            height: 40.h,
                            width: 190.w,
                            // yeha ani model ma update garne tw honi .
                            child: addTransactionField("item".tr,
                                type: RollSwitcherControlls.isSale
                                    ? textLabel1
                                    : textLabel2,
                                con: fieldslist[2]));
                      }),
                  SizedBox(
                      height: 40.h,
                      width: 190.w,
                      child: Obx(
                        () => addTransactionField(
                          "total".tr + " " + "amnt".tr,
                          con: fieldslist[1],
                          isnum: true,
                          isReq: obscontroll.reqFields[1].value,
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  optional,
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 3.h),
                child: divEr,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: SizedBox(
                        height: 40.h,
                        width: 110.w,
                        child: addTransactionField(
                            "total".tr + " " + "quantity".tr,
                            isnum: true,
                            con: fieldslist[3],
                            onchanged: TextFieldController.changeAmount)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0.w),
                    child: clearBUtton("✘", CreateControlls().onclearFields),
                  ),
                  const Calender(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  optional,
                ],
              ),
              divEr,
              // additional details
              CustomTile(
                trailingicon: Icons.more_horiz,
                body: Container(
                  child: expandedTile(),
                ),
                expansionHeight: 50.h,
                nonExpandedHeight: 24.h,
                nonExpandedWidth: 388.w,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "details".tr,
                      style: optionblack,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget expandedTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.production_quantity_limits,
          color: red,
        ),
        DropDownButton(itemlist),
        SizedBox(
            height: 40.h,
            width: 100.w,
            child: addTransactionField("per".tr + " " + "quantity".tr,
                onchanged: TextFieldController.changeAmount,
                con: fieldslist[4],
                isnum: true)),
        SizedBox(
            height: 40.h,
            width: 130.w,
            child: addTransactionField("price".tr,
                onchanged: TextFieldController.changeAmount,
                isnum: true,
                con: fieldslist[5],
                ontap: CreateControlls.checkPerQuantity)),
      ],
    );
  }

  Widget formTail() {
    return GetBuilder<CreateControlls>(
        init: CreateControlls(),
        builder: (b) {
          return Material(
            elevation: 3,
            child: Container(
                height: 350.h,
                color: Colors.white,
                alignment: Alignment.topCenter,
                child: AnimatedList(
                    controller: scrollController,
                    key: listkey,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    reverse: true,
                    shrinkWrap: true,
                    itemBuilder: (con, index, animate) {
                      return InfoTile(
                        b.allinfoItems[index],
                        index,
                        haveCheckbox: false,
                        isSales: b.allinfoItems[index].isSell,
                      );
                    })),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    RollSwitcherControlls.isSale = false;
    CreateControlls().onclearFields();
  }
}
