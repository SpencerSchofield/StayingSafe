import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:staying_safe/screens/home_screen.dart';
import 'package:staying_safe/styles/styles.dart';

final emailcontroller = TextEditingController();
final passwordcontroller = TextEditingController();
bool ispassword = true;
bool isLoggedIn = false;
User? user = FirebaseAuth.instance.currentUser;
final appbar = AppBar(title: const Text('Staying safe'));
var error = StringBuffer();

class AuthApp extends StatefulWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    final appbarheight = appbar.preferredSize.height;

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: appbar,
        body: Padding(
            padding: const EdgeInsets.all(60.0),
            child: SizedBox(
                height: (screenHeight - appbarheight),
                width: screenwidth,
                child: Builder(builder: (BuildContext context) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (Image.asset("images/Logo.png")),
                        TextFormField(
                          key: const ValueKey("Email"),
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          controller: emailcontroller,
                        ),
                        TextField(
                          key: const ValueKey("password"),
                          textAlign: TextAlign.left,
                          obscureText: ispassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.security),
                              suffixIcon: InkWell(
                                  onTap: _togglePasswordView,
                                  child: const Icon(Icons.visibility))),
                          controller: passwordcontroller,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButton(
                                    style: Styles.loginStyle,
                                    //sign in button
                                    child: const Text('Sign In '),
                                    onPressed: () async {
                                      error.clear();
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: emailcontroller.text,
                                                password:
                                                    passwordcontroller.text);
                                        isLoggedIn = true;
                                        setState(() {});
                                        error.clear();
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          error.write(
                                              'No user found for that email.');
                                        } else if (e.code == 'wrong-password') {
                                          error.write(
                                              'Wrong password provided for that user');
                                        }
                                        print(error);
                                      }
                                      final snackBar = SnackBar(
                                        content: Text(error.toString()),
                                      );
                                      if (isLoggedIn == true) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Homescreen()),
                                        );
                                      } else if (isLoggedIn == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButton(
                                    child: const Text('Sign Up '),
                                    style: Styles.loginStyle,
                                    onPressed: () async {
                                      error.clear();
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: emailcontroller.text,
                                                password:
                                                    passwordcontroller.text);
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
                                      if (isLoggedIn == true) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Homescreen()),
                                        );
                                      } else if (isLoggedIn == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }),
                              ),
                            ]),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  fixedSize: const Size(200, 50)),
                              onPressed: () async {
                                if (emailcontroller.text == '') {
                                  const snackBar = SnackBar(
                                    content: Text('please enter a valid email'),
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
                }))));
  }

  void _togglePasswordView() {
    if (ispassword == true) {
      ispassword = false;
    } else {
      ispassword = true;
    }
    setState(() {});
  }
}
