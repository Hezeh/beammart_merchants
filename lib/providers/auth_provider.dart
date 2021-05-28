import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import '../services/profile_service.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider with ChangeNotifier {
  // FirebaseAuth instance;
  final FirebaseAuth firebaseAuth;
  final ProfileService profileService = ProfileService();
  // Profile? _profile;
  bool? _loading = true;

  AuthenticationProvider(this.firebaseAuth) {
    // getBusinessProfile();
  }

  // Using Stream to listen to Authentication State;
  Stream<User?> get authState => firebaseAuth.authStateChanges();
  User? get user => firebaseAuth.currentUser;
  bool? get loading => _loading;

  bool? get loadingAuth => _loading;

  // getBusinessProfile() async {
  //   if (user != null) {
  //     final Profile? newProfile = await profileService
  //         .getCurrentProfile(firebaseAuth.currentUser!.uid);
  //     _profile = newProfile;
  //   }
  //   _loading = false;
  //   notifyListeners();
  // }

  // addBusinessProfile(Map<String, dynamic> _json, String userId) async {
  //   _profileDb.doc(userId).set(_json, SetOptions(merge: true));
  //   final Profile? newProfile = await profileService.getCurrentProfile(userId);
  //   if (newProfile != null) {
  //     _profile = newProfile;
  //   }
  //   notifyListeners();
  // }

  // changeLocation(String _userId, GeoPoint _location) async {
  //   _profileDb
  //       .doc(_userId)
  //       .set({'gpsLocation': _location}, SetOptions(merge: true));
  // }

  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleSignIn.clientId != null) {
      googleSignIn.signInSilently();
      _loading = false;
      print(googleSignIn.clientId);
      notifyListeners();
    }

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        await firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
      } else {
        // print("Missing Google Auth Token");
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      // print("Sign in aborted by user");
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
    _loading = false;
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogleWeb() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    if (googleSignIn.clientId != null) {
      googleSignIn.signInSilently();
      _loading = false;
      print(googleSignIn.clientId);
      notifyListeners();
    }
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    // _profile = null;
    _loading = null;
    notifyListeners();
    return firebaseAuth.signOut();
  }
}
