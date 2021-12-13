import 'package:app/screens/homescreen/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// I AM FOLLOWING THE BLOC PATTERN FOR EACH SCREEN I HAVE 4 COOMPONENTS
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390.0, 844.0),
      builder: () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.dark),
          darkTheme: ThemeData.dark(),
          title: "Hisab Kitab",
          home: const HisabKitabHome(),
        );
      },
    );
  }
}
