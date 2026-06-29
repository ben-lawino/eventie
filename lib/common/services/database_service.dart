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

  // Stream of a single profile
  Stream<ProfileModel?> getProfileStream(String uid) {
    return _db.collection('profiles').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return ProfileModel.fromJson(snapshot.data()!);
      }
      return null;
    });
  }

  // Stream of profiles for admin
  Stream<List<Map<String, dynamic>>> getPendingOrganizers() {
    return _db
        .collection('profiles')
        .where('isApproved', isEqualTo: false)
        .where('businessName', isNotEqualTo: null)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {...doc.data(), 'uid': doc.id})
            .toList());
  }

  // Approve an organizer
  Future<void> approveOrganizer(String uid) async {
    await _db.collection('profiles').doc(uid).update({'isApproved': true});
  }
}

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});
