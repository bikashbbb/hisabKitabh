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

// secret keyword for itemnms
/// this will keep record of the object index
String objectkoIndex = "I";
String uptoOnline = "up";
