// this file contains all the navigator of the screes

import 'package:app/screens/login/loginhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

void onLoginClicked() {
  Get.to(() =>  const LoginScreen());
}

void onback(){
  Get.back();
}

void popDialog(BuildContext ctx){
      Navigator.of(ctx).pop();
}