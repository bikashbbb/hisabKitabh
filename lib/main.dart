// ignore_for_file: prefer_typing_uninitialized_variables
// todo : save the short forms of the quantity types..
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/homescreen/ui/home.dart';
import 'package:app/translations/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// I AM FOLLOWING THE BLOC PATTERN FOR EACH SCREEN I HAVE 4 COOMPONENTS
// let it be coming from hive database...
void main() async {
  Box obj = await hiveInitializer();
  loginValidator(obj);
}

Future<Box> hiveInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox(lendbox);
  return await Hive.openBox(userD);
}

void loginValidator(Box box) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final bool isloggedIn;
  const MyApp({Key? key, this.isloggedIn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390.0, 844.0),
      builder: () {
        return GetMaterialApp(
          translations: Languages(),
          locale: const Locale("en", 'US'),
          theme: ThemeData(fontFamily: "customfont"),
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          title: "Hisab Kitab",
          home: const HisabKitabHome(),
        );
      },
    );
  }
}
