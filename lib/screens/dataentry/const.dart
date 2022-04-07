// i will have all the varibales that i have to use in local db.
// hive key  items
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

String daily = "daily";

// hive box names
String userD = "User Data";
String lendbox = "lenddata";
// hive keys names
String acc = "Accounts";
String lastUniq = "last unique num";

/// use this to add up with the code to store total amount,
String tAmount = "t";
Box dailyBox = Hive.box(userD);
Box lendBox = Hive.box(lendbox);

// secret keyword for itemnms
/// this will keep record of the object index
String objectkoIndex = "I";
String uptoOnline = "up";

ScrollPhysics scrollPhysics = const ScrollPhysics();
final GlobalKey<AnimatedListState> listkey = GlobalKey<AnimatedListState>();
final ScrollController controller = ScrollController();


var appStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light);
