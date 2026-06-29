class ProfileModel {
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String email;
  final String phone;
  final String country;
  final String? avatarPath;
  final bool isApproved;
  // KYC Fields
  final String? businessName;
  final String? idNumber;
  final String? website;

  const ProfileModel({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phone,
    required this.country,
    this.avatarPath,
    this.isApproved = true,
    this.businessName,
    this.idNumber,
    this.website,
  });

  ProfileModel copyWith({
    String? fullName,
    String? dateOfBirth,
    String? gender,
    String? email,
    String? phone,
    String? country,
    String? avatarPath,
    bool? isApproved,
    String? businessName,
    String? idNumber,
    String? website,
  }) {
    return ProfileModel(
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      avatarPath: avatarPath ?? this.avatarPath,
      isApproved: isApproved ?? this.isApproved,
      businessName: businessName ?? this.businessName,
      idNumber: idNumber ?? this.idNumber,
      website: website ?? this.website,
    );
  }
}