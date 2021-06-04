import 'package:beammart_merchants/screens/login_email_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/google_signin_button.dart';
import 'package:beammart_merchants/providers/auth_provider.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
      ),
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
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2.5,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(15),),
            margin: EdgeInsets.only(
              top: 60,
              bottom: 30,
            ),
            child: Center(
              child: Text("Sign In to your account or create one",
                  style: GoogleFonts.gelasio(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              // heightFactor: 2,
              child: GoogleSignInButton(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Center(
              child: SignInButton(
                Buttons.FacebookNew,
                onPressed: () {
                  _authProvider.loginFacebook();
                },
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.all(15),
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(
          //     top: 10,
          //     bottom: 10,
          //   ),
          //   child: Center(
          //     child: SignInButton(
          //       Buttons.Microsoft,
          //       onPressed: () {},
          //       elevation: 20,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(40),
          //       ),
          //       padding: EdgeInsets.all(15),
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(
          //     top: 10,
          //     bottom: 10,
          //   ),
          //   child: Center(
          //     child: SignInButton(
          //       Buttons.Yahoo,
          //       onPressed: () {},
          //       elevation: 20,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(40),
          //       ),
          //       padding: EdgeInsets.all(15),
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Center(
              child: SignInButton(
                Buttons.Email,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LoginEmailPasswordScreen(),
                    ),
                  );
                },
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.all(15),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
