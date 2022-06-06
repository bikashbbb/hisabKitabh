import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:get/get.dart';

class DialogControlls extends GetxController {
  int currentIndex = 0;
  int cureentAccIndex = 0;
  double percentage = 0.0;
  int iOne = 0;
  bool isFinished = false;
  int totalRcordCount = 0;

  /// every 10 wota index ma update garne !
  String getCurrentIndex() {
    return currentIndex.toString();
  }

  /// current acc ko index will be one
  String getCurrentAccIndex() {
    return currentIndex.toString();
  }

  void updateIsfinish() {
    isFinished = !isFinished;
    currentIndex = totalRcordCount;
    update();
  }

  void updateCurrentAccIndex() {
    cureentAccIndex += 1;
    update();
  }

  void updateTotalRcrdCount(int total) {
    totalRcordCount = total;
    update();
  }

  double getPercentage() {
    return percentage = currentIndex / totalRcordCount;
  }

  void onDoneClickedHome() async {
    await Get.delete<DialogControlls>();
    if (UpperNavigationBar.iSoffline()) {
      final con = Get.find<EntryControlls>();
      con.updateEntry();
    }

    CreateEntry.onBack();
  }
}
