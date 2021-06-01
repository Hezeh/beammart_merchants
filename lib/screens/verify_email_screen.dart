import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  // User? _user = FirebaseAuth.instance.currentUser;

  var auth = FirebaseAuth.instance;
// Retrieve the email from wherever you stored it
  var emailAuth = "someemail@domain.com";
// Confirm the link is a sign-in with email link.

  @override
  void initState() {
    super.initState();
    if (auth.isSignInWithEmailLink(emailLink)) {
      // The client SDK will parse the code from the link for you.
      auth
          .signInWithEmailLink(email: emailAuth, emailLink: emailLink)
          .catchError(
              (onError) => print('Error signing in with email link $onError'))
          .then((value) {
        // You can access the new user via value.user
        // Additional user info profile *not* available via:
        // value.additionalUserInfo.profile == null
        // You can check if the user is new or existing:
        // value.additionalUserInfo.isNewUser;
        var userEmail = value.user;
        print('Successfully signed in with email link!');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "A verification email has been sent to ${_user!.email} . Please verify."),
      ),
    );
  }
}
