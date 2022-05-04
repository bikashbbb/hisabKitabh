import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeControllerInterface extends GetxController {
  final bool isDaily;
  late HiveDatabase _obj;

  HomeControllerInterface(this.isDaily) {
    _obj = HiveDatabase(isDaily, boxKonaam: "");
  }

  bool doesAccExists() {
    /// first check for wifi and login info ! if both meets go for online else offline !
    if (_obj.isAccountCreated(isDaily) && true) {
      // true ko thau ma firebase checker of has data yedi dubai ma data xaina vane false;
      return true;
    }
    return false;
  }
}
