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
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
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
