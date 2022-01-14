import 'package:flutter/material.dart';

var homeDecoration = const BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: Colors.black12,
          offset: Offset(-5, -5),
          blurRadius: 15,
          spreadRadius: 1),
      BoxShadow(
          color: Colors.black12,
          offset: Offset(5, -5),
          blurRadius: 15,
          spreadRadius: 1)
    ],
    color: Colors.white,
    borderRadius: BorderRadius.only(topRight: Radius.circular(100)));

BoxDecoration entryButton = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(14)),
    border: Border.all(color: Colors.black),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
          color: Colors.black12,
          offset: Offset(-5, -5),
          blurRadius: 15,
          spreadRadius: 1),
    ]);

BoxDecoration dateButtonDec =const  BoxDecoration(
  color:  Colors.green
);
