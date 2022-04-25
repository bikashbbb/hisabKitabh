import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:get/get.dart';

// TODO: have an algorithm for total amount!
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

  /// updates the cureent index with the range of five
  /* void updateCurrentIndex() {
    iOne += 1;
    currentIndex += 1;
    if (iOne == 5) {
      update();
      iOne = 0;
    }
  } */

  void updateCurrentAccIndex() {
    cureentAccIndex += 1;
    update();
  }

  void updateTotalRcrdCount(int total) {
    totalRcordCount = total;
    update();
  }

  /// updates whenever current index is updated .. will become a great programmer fuck yes yes !!! developer with
  double getPercentage() {
    // p = c count * total count /100
    return percentage = currentIndex / totalRcordCount;
  }

  // total c = 3, current = 3 3*3
  void onDoneClicked(bool isHOme) async {
    
     isHOme ? onDoneClickedHome(isHOme) : Get.back();
  }

  void onDoneClickedHome(bool ishome) async {
    await Get.delete<DialogControlls>();
    await Get.delete<EntryControlls>();
    CreateEntry.onBack();
  }
}
