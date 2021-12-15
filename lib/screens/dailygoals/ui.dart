import 'package:flutter/material.dart';

class DailyGoalsPage extends StatelessWidget {
  const DailyGoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black,
          
          )],
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(100))),
    );
  }
}
