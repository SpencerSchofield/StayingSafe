import "package:flutter/material.dart";
import "package:staying_safe/services/map.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Map",
      home: MapWidget(),
    );
  }
}
