// todo : save the short forms of the quantity types..
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/homescreen/ui/home.dart';
import 'package:app/translations/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
// todays worl:
//1) setup lend entry page
// 2) setup settlement
// 3) setup firebase and boom i am done with the first version ! 

// have a settle button in the all transaction page..
// have change the create order page , some extend !!. and 
// lets shape the lend entry also , have some minor changes in lend entry thats all...!! and after that i will have the firebase connected with my app and boom done !
void main() async {
  Box obj = await hiveInitializer();
  loginValidator(obj);
}

Future<Box> hiveInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  return await Hive.openBox(dailyNuserinfo);
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
          theme: ThemeData(
            fontFamily: "customfont",
          ),
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          title: "Hisab Kitab",
          home: const HisabKitabHome(),
        );
      },
    );
  }
}
