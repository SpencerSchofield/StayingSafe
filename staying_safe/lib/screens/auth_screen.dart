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
    var error = StringBuffer();

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(title: const Text('Staying safe')),
            //(Logged ' + (user == null ? 'out' : 'in') + ')'
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton(
                                        //sign in button
                                        child: const Text('Sign In '),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                        ),
                                        onPressed: () async {
                                          error.clear();
                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: emailcontroller.text,
                                                    password: passwordcontroller
                                                        .text);
                                            isLoggedIn = true;
                                            setState(() {});
                                            error.clear();
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'user-not-found') {
                                              error.write(
                                                  'No user found for that email.');
                                            } else if (e.code ==
                                                'wrong-password') {
                                              error.write(
                                                  'Wrong password provided for that user');
                                            }
                                            print(error);
                                          }
                                          final snackBar = SnackBar(
                                            content: Text(error.toString()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          if (isLoggedIn == true) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()),
                                            );
                                          }
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton(
                                        child: const Text('Sign Up '),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black),
                                        onPressed: () async {
                                          error.clear();
                                          try {
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: emailcontroller.text,
                                                    password: passwordcontroller
                                                        .text);
                                            setState(() {});
                                            isLoggedIn = true;
                                            error.clear();
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'weak-password') {
                                              error.write(
                                                  'The password provided is too weak.');
                                            } else if (e.code ==
                                                'email-already-in-use') {
                                              error.write(
                                                  'The account already exists for that email.');
                                            }
                                          } catch (e) {
                                            print(error);
                                          }
                                          final snackBar = SnackBar(
                                            content: Text(error.toString()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

                                          if (isLoggedIn == true) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()),
                                            );
                                          }
                                        }),
                                  ),
                                ]),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black),
                                  onPressed: () async {
                                    if (emailcontroller.text == '') {
                                      const snackBar = SnackBar(
                                        content:
                                            Text('please enter a valid email'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: emailcontroller.text);
                                    }
                                  },
                                  child: const Text('Forgot password?')),
                            )
                          ]);
                    })))));
  }
}
