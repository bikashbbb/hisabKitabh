import 'package:get/get.dart';

class DialogControlls extends GetxController {
  late Rx<int> currentIndex;
  late Rx<int> cureentAccIndex;
  
  int iOne = 5;
  int iTwo = 1;

  /// every 10 wota index ma update garne !
  String getCurrentIndex() {
    return currentIndex.toString();
  }

  /// current acc ko index will be one
  String getCurrentAccIndex() {
    return currentIndex.toString();
  }
}
