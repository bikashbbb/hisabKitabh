import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeControllerInterface extends GetxController {
  final bool isDaily;
  late HiveDatabase _obj;

  HomeControllerInterface(this.isDaily) {
    _obj = HiveDatabase(isDaily, boxKonaam: "");
  }

  bool doesAccExists() {
    return _obj.isAccountCreated(isDaily);
  }
}
