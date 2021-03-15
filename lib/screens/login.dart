import 'package:flutter/material.dart';
import '../widgets/google_signin_button.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pinkAccent,
            Colors.purple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            heightFactor: 2,
            child: GoogleSignInButton(),
          ),
        ],
      ),
    ));
  }
}