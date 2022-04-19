import 'package:get/get.dart';

// TODO: DELETE THE ACCOUNT FINISH IT UP..
class DialogControlls extends GetxController {
  int currentIndex = 0;
  int cureentAccIndex = 0;
  double percentage = 0.0;
  int iOne = 0;
  bool isFinished = false;

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
    percentage = 100;
    update();
  }

  /// updates the cureent index with the range of five
  void updateCurrentIndex() {
    iOne += 1;
    currentIndex += 1;
    if (iOne == 5) {
      update();
      iOne = 0;
    }
  }

  void updateCurrentAccIndex() {
    cureentAccIndex += 1;
    update();
  }

  /// updates whenever current index is updated .. will become a great programmer fuck yes yes !!! developer with
  double getPercentage(int totalCount) {
    // p = c count * total count /100
    return percentage = currentIndex / totalCount;
  }
  // total c = 3, current = 3 3*3
}
