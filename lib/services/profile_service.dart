import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/profile.dart';

final CollectionReference _db =
    FirebaseFirestore.instance.collection('profile');

class ProfileService {

  Future<Profile> getCurrentProfile(String userId) async {
    final DocumentSnapshot profile = await _db.doc(userId).get();
    if (profile != null) {
      return Profile.fromJson(profile.data());
    }
    // return profile;
    return null;
  }
}
