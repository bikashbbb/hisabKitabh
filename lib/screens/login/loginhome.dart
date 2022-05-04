import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/login/logincontrolls.dart';
import 'package:app/screens/login/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: iconGreen,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: TextButton(
                onPressed: onback,
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: iconwhite,
                  size: 35.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "log".tr,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "wb".tr,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(0),
                                // here have our app icon
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        TextButton(
                          onPressed: () {
                            LoginControlls().onGoogleLogin(context);
                          },
                          child: Container(
                            width: 300.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black),
                            child: Row(
                              children: [
                                SizedBox(width: 10.w),
                                Image.asset("assets/images/google ing.jpg"),
                                Text(
                                  "lga".tr,
                                  style: white15,
                                ),
                                Expanded(
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                    color: iconwhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "msg".tr,
                          style: subTitle,
                        ),
                        Text(
                          "msg2".tr,
                          style: subTitle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
