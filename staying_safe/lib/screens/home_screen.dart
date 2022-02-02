import 'package:firebase_auth/firebase_auth.dart';
import 'package:staying_safe/contactpage.dart';
import 'package:staying_safe/screens/Map_screen.dart';
import 'package:staying_safe/screens/settings_screen.dart';
import "package:flutter/material.dart";
import 'package:staying_safe/screens/auth_screen.dart';
import 'package:staying_safe/screens/sos_screen.dart';
import "package:staying_safe/services/map.dart";
import 'package:staying_safe/contactpage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Mapscreen(),
    SOSscreen(),
    ContactPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body is the majority of the screen.
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Trusted contacts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
