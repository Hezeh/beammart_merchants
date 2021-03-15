import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        authProvider.signInWithGoogle();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
