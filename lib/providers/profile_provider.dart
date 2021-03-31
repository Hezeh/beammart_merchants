import 'dart:io';

import 'package:beammart_merchants/services/profile_service.dart';
import 'package:beammart_merchants/utils/upload_files_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/profile.dart';

CollectionReference _profileRef =
    FirebaseFirestore.instance.collection('profile');

class ProfileProvider with ChangeNotifier {
  final ProfileService profileService = ProfileService();
  Profile? _profile;
  final User? _user;
  bool _loading = true;

  ProfileProvider(this._user) {
    if (this._user != null) {
      getBusinessProfile(this._user!);
    }
  }

  Profile? get profile => _profile;
  bool get loading => _loading;

  getBusinessProfile(User _user) async {
    // Get User Profile from firestore
    final DocumentSnapshot _profileDoc = await _profileRef.doc(_user.uid).get();
    if (_profileDoc.exists) {
      _profile = Profile.fromJson(_profileDoc.data()!);
    }
    _loading = false;
    notifyListeners();
  }

  // createBusinessProfile(Profile profile, String userId) {
  //   _profileRef.doc(userId).set(profile.toJson());
  //   notifyListeners();
  // }

  addBusinessProfile(Map<String, dynamic> _json, String userId) async {
    _profileRef.doc(userId).set(_json, SetOptions(merge: true));
    final Profile? newProfile = await profileService.getCurrentProfile(userId);
    if (newProfile != null) {
      _profile = newProfile;
    }
    notifyListeners();
  }

  changeLocation(String _userId, GeoPoint _location) async {
    _profileRef
        .doc(_userId)
        .set({'gpsLocation': _location}, SetOptions(merge: true));
     _profile!.gpsLocation = _location;
  }

  changeBusinessProfilePhoto(File? photo, String? userId) async {
    if (photo != null) {
      // Upload the photo & Get the image url
      String? _imageUrl = await uploadFile(photo);
      // Set the value
      _profile!.businessProfilePhoto = _imageUrl;
      _profileRef.doc(userId).set(
        {'businessProfilePhoto': _imageUrl},
        SetOptions(merge: true),
      );
    }
    notifyListeners();
  }
}
