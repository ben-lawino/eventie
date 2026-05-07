class ProfileModel {
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String email;
  final String phone;
  final String country;
  final String? avatarPath; // null = use asset default

  const ProfileModel({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phone,
    required this.country,
    this.avatarPath,
  });

  ProfileModel copyWith({
    String? fullName,
    String? dateOfBirth,
    String? gender,
    String? email,
    String? phone,
    String? country,
    String? avatarPath,
  }) {
    return ProfileModel(
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}