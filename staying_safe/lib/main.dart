import "package:flutter/material.dart";
import "./screens/auth_screen.dart";
import 'package:firebase_core/firebase_core.dart';
import 'contactpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AuthApp());
}
