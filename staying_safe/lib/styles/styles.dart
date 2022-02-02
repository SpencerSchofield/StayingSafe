// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
//import 'package:staying_safe/styles/util.dart';

class Styles {
  static final ButtonStyle loginStyle = ElevatedButton.styleFrom(
      primary: Colors.black,
      minimumSize: const Size(100, 50),
      // //shape: new RoundedRectangleBorder(
      //   borderRadius: new BorderRadius.circular(30.0),
      // ),
      textStyle: const TextStyle(
          color: Colors.black, //fontSize: 20,
          fontStyle: FontStyle.italic));

  static final ButtonStyle sosStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(100, 75),
      primary: Colors.blue,
      padding: const EdgeInsets.all(10),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  static final ButtonStyle sosTopButton = ElevatedButton.styleFrom(
      minimumSize: const Size(90, 90),
      primary: Colors.blue,
      padding: const EdgeInsets.all(10),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  static final ButtonStyle sosExitButton = ElevatedButton.styleFrom(
      minimumSize: const Size(100, 75),
      primary: Colors.red,
      padding: const EdgeInsets.all(10),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  static final ButtonStyle sosTrue = ElevatedButton.styleFrom(
      minimumSize: const Size(10, 10),
      primary: Colors.blue,
      padding: const EdgeInsets.all(5),
      textStyle: const TextStyle(fontSize: 5, fontWeight: FontWeight.bold));

  static final ButtonStyle SOSButton = ElevatedButton.styleFrom(
      minimumSize: const Size(300, 300),
      shape:
          const CircleBorder(side: BorderSide(width: 5, color: Colors.green)),
      primary: Colors.blue,
      padding: const EdgeInsets.all(10),
      textStyle: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold));
}
