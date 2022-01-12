import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';

Widget addTransactionField(String label,{String type = "p"}) {
  return TextField(
    
    style: inputStyle,
    decoration: InputDecoration(
        
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconGreen, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        label: RichText(
          text: TextSpan(
children: [
  TextSpan(
    text: label,
    style: const TextStyle(color: Colors.black)
  ),
  TextSpan(
    text: type[0]=="p"?"": "  ( $type )",
    style: TextStyle(
      color:
      type[0]=="s"?Colors.green:Colors.red,
      fontWeight: FontWeight.bold
    )
  )
]
          ),
          
        ),
        labelStyle: const TextStyle(color: Colors.black)),
  );
}

