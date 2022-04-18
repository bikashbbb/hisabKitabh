import 'package:get/get.dart';

// TODO: DELETE THE ACCOUNT FINISH IT UP..
class DialogControlls extends GetxController {
  int currentIndex = 1;
  Rx<int> cureentAccIndex = 1.obs;
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
    cureentAccIndex.value += 1;
  }

  void onSucess() {
    // give the done button in the ui!
  }

  /// updates whenever current index is updated .. will become a great programmer fuck yes yes !!! developer with
  double getPercentage(int totalCount) {
    // p = c count * total count /100
    return percentage = (currentIndex * totalCount) / 100;
  }
}
