// i will have all the varibales that i have to use in local db.
// hive key  items
import 'package:hive/hive.dart';

String daily = "daily";

// hive box names
String userD = "User Data";
String lendbox = "lenddata";
// hive keys names
String acc = "Accounts";
String lastUniq = "last unique num";

Box dailyBox = Hive.box(userD);
Box lendBox = Hive.box(lendbox);
// ("account":"code", "bik":0) - acc