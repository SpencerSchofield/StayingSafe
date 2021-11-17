import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:staying_safe/screens/home_screen.dart';

class AuthApp extends StatefulWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool isLoggedIn = false;

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
                title: Text('(Logged ' + (user == null ? 'out' : 'in') + ')')),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Builder(builder: (BuildContext context) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              key: const ValueKey("username"),
                              textAlign: TextAlign.center,
                              decoration:
                                  const InputDecoration(hintText: "Username"),
                              controller: emailcontroller,
                            ),
                            TextFormField(
                              key: const ValueKey("password"),
                              textAlign: TextAlign.center,
                              decoration:
                                  const InputDecoration(hintText: "Password"),
                              controller: passwordcontroller,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                //sign in button
                                child: const Text('Sign In '),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () async {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text);
                                    setState(() {});
                                    isLoggedIn == true;
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      throw ('No user found for that email.');
                                    } else if (e.code == 'wrong-password') {
                                      throw ('Wrong password provided for that user.');
                                    }
                                  }
                                  if (user != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  }
                                }),
                            ElevatedButton(
                                child: const Text('Sign Up '),
                                onPressed: () async {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text);
                                    setState(() {});
                                    isLoggedIn = true;
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      throw ('The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      throw ('The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    rethrow;
                                  }
                                  if (isLoggedIn == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  }
                                }),
                            ElevatedButton(
                                child: const Text('Log Out '),
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  setState(() {});
                                })
                          ]);
                    })))));
  }
}
