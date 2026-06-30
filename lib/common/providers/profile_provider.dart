import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/profile_model.dart';


class ProfileNotifier extends StateNotifier<ProfileModel> {
  ProfileNotifier()
      : super(const ProfileModel(
    fullName: '',
    dateOfBirth: '',
    gender: '',
    email: '',
    phone: '',
    country: '',
    avatarUrl: null,
    isApproved: true,
  ));

  void update(ProfileModel updated) => state = updated;
}

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileModel>((ref) {
  return ProfileNotifier();
});