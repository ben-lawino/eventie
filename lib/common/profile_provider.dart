import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/profile_model.dart';


class ProfileNotifier extends StateNotifier<ProfileModel> {
  ProfileNotifier()
      : super(const ProfileModel(
    fullName: 'Ben lawin',
    dateOfBirth: '6/27/1960',
    gender: 'Male',
    email: 'lawinwes@gmail.com',
    phone: '+254 700628088',
    country: 'Kenya',
  ));

  void update(ProfileModel updated) => state = updated;
}

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileModel>((ref) {
  return ProfileNotifier();
});