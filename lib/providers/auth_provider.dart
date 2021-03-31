import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import '../models/profile.dart';
import '../services/profile_service.dart';
import 'package:flutter/foundation.dart';

final CollectionReference _profileDb =
    FirebaseFirestore.instance.collection('profile');

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
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
    _loading = false;
    notifyListeners();
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
