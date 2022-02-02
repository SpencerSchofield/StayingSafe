// ignore_for_file: unnecessary_new

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staying_safe/screens/settings_screen.dart';
import 'auth_screen.dart';
import 'package:staying_safe/styles/styles.dart';

class SOSscreen extends StatefulWidget {
  const SOSscreen({Key? key}) : super(key: key);

  @override
  _SOSscreenState createState() => _SOSscreenState();
}

//for settings and logout buttons.
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

bool _isVisibleExit = false;
bool _isVisibleTimer = true;
CountDownController _controller = CountDownController();

class _SOSscreenState extends State<SOSscreen> {
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Colors.blue,
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
    );

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey,
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //Center Column contents vertically,
        crossAxisAlignment:
            CrossAxisAlignment.center, //Center Column contents horizontally
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.contacts,
                  color: Colors.black,
                  size: 30.0,
                ),
                label: const Text('EMERGENCY'),
                onPressed: () {},
                style: Styles.sosTopButton,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.contacts,
                  color: Colors.black,
                  size: 30.0,
                ),
                style: Styles.sosTopButton,
                label: const Text('CONTACTS'),
                onPressed: () {},
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(40),
          ),
          Stack(
              alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                CircularCountDownTimer(
                    width: 300,
                    height: 300,
                    autoStart: false,
                    controller: _controller,
                    duration: 10,
                    strokeWidth: 15,
                    fillColor: Colors.red,
                    ringColor: Colors.green),
                Column(
                  children: [
                    Visibility(
                      visible: _isVisibleTimer,
                      child: ElevatedButton(
                        style: Styles.SOSButton,
                        onPressed: () {
                          setState(() {
                            _isVisibleTimer = false;
                            _isVisibleExit = true;
                            _controller.restart();
                          });
                        },
                        child: const Text('SOS'),
                      ),
                    )
                  ],
                ),
              ]),

          // const Padding(
          //   padding: EdgeInsets.all(10),
          // ),

          const Padding(
            padding: EdgeInsets.all(10),
          ),
          Visibility(
              visible: _isVisibleExit,
              child: Column(
                children: [
                  ElevatedButton(
                    style: Styles.sosExitButton,
                    onPressed: () {
                      _controller.restart();
                      _controller.pause();
                      setState(() {
                        _isVisibleTimer = true;
                        _isVisibleExit = false;
                      });
                    },
                    child: const Text('EXIT SOS MODE'),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
