// i will have all the varibales that i have to use in local db.
// hive key  items
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String daily = "daily";
String aName = "";
// hive box names
String dailyNuserinfo = "User Data";
String lendAcc = "Lend acc";
// hive keys names
String dailyacc = "Accounts";
String lastUniq = "last unique num";

/// use this to add up with the code to store total amount,
String tAmount = "t";
bool isDaily = true;

// secret keyword for itemnms
/// this will keep record of the object index
String objectkoIndex = "I";
String uptoOnline = "up";

ScrollPhysics scrollPhysics = const ScrollPhysics();
final GlobalKey<AnimatedListState> listkey = GlobalKey<AnimatedListState>();
final ScrollController scrollController = ScrollController();

var appStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light);
