import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/ui/entryhome.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class LendAccHome extends StatefulWidget {
  const LendAccHome({Key? key}) : super(key: key);

  @override
  State<LendAccHome> createState() => _LendAccHomeState();
}

class _LendAccHomeState extends State<LendAccHome> {
  @override
  void initState() {
    super.initState();
    Get.delete<EntryControlls>();
  }

  @override
  Widget build(BuildContext context) {
    return const DailyEntryPage(false);
  }
}
