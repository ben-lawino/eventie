class ProfileModel {
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String email;
  final String phone;
  final String country;
  final String? avatarUrl;
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
    this.avatarUrl,
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
    String? avatarUrl,
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
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isApproved: isApproved ?? this.isApproved,
      businessName: businessName ?? this.businessName,
      idNumber: idNumber ?? this.idNumber,
      website: website ?? this.website,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country'] ?? '',
      avatarUrl: json['avatarUrl'],
      isApproved: json['isApproved'] ?? true,
      businessName: json['businessName'],
      idNumber: json['idNumber'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'email': email,
      'phone': phone,
      'country': country,
      'avatarUrl': avatarUrl,
      'isApproved': isApproved,
      'businessName': businessName,
      'idNumber': idNumber,
      'website': website,
    };
  }
}