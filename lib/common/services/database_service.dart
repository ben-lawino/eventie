import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/profile_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save or update profile
  Future<void> saveProfile(String uid, ProfileModel profile) async {
    await _db.collection('profiles').doc(uid).set(profile.toJson());
  }

  // Update a specific field (e.g., avatar URL)
  Future<void> updateProfileField(String uid, Map<String, dynamic> data) async {
    await _db.collection('profiles').doc(uid).update(data);
  }

  // Get profile
  Future<ProfileModel?> getProfile(String uid) async {
    final doc = await _db.collection('profiles').doc(uid).get();
    if (doc.exists) {
      return ProfileModel.fromJson(doc.data()!);
    }
    return null;
  }

  // Stream of profiles for admin
  Stream<List<ProfileModel>> getPendingOrganizers() {
    return _db
        .collection('profiles')
        .where('isApproved', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProfileModel.fromJson(doc.data()))
            .toList());
  }
}

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});
