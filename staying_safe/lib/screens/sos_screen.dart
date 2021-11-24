import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staying_safe/screens/settings_screen.dart';

import 'auth_screen.dart';

class SOSscreen extends StatefulWidget {
  const SOSscreen({Key? key}) : super(key: key);

  @override
  _SOSscreenState createState() => _SOSscreenState();
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const setting()),
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

class _SOSscreenState extends State<SOSscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Kent Walksafe'),
      automaticallyImplyLeading: false, //remove backbutton
      centerTitle: true,
      actions: [
        PopupMenuButton<int>(
            icon: const Icon(Icons.menu),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('Log Out'),
                  ),
                ])
      ],
    ));
  }
}
