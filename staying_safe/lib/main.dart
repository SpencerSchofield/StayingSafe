import "package:flutter/material.dart";
import "./screens/auth_screen.dart";
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AuthApp());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthApp(),
      theme: ThemeData(primaryColor: Colors.black),
    );
  }
}
