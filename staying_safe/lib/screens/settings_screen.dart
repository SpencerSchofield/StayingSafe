import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staying_safe/screens/Map_screen.dart';
import 'package:staying_safe/screens/auth_screen.dart';
import 'package:staying_safe/screens/home_screen.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false, //remove backbutton
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
              icon: const Icon(Icons.menu),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text('Main Menu'),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Log Out'),
                    ),
                  ])
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );
        break;
      case 1:
        () async {
          await FirebaseAuth.instance.signOut();
        };
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthApp()),
        );
        break;
    }
  }
}
