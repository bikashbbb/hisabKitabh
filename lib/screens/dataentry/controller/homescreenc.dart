import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/login/logincontrolls.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeControllerInterface extends GetxController {
  final bool isDaily;
  late HiveDatabase _obj;

  HomeControllerInterface(this.isDaily) {
    _obj = HiveDatabase(isDaily, boxKonaam: "");
  }

  bool doesAccExists() {
    // ofline data xa arthawa, we should be checking if user is connected to internet or not 
    // if user is not connnecting to internet then , arko box key use garna parxa data display garna 
    if (_obj.isAccountCreated(isDaily) || LoginControlls.isUserLoggedin()) {
      return true;
    }

    return false;
  }
}
