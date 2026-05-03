class UserModel {
  final String? id;
  final String? fullName;
  final String? bio;
  final String? email;
  final String? phoneNumber;
  final String? location;
  final String? postalCode;
  final String? profileImageUrl;
  final String? coverImageUrl;

  const UserModel({
    this.id,
    this.fullName,
    this.bio,
    this.email,
    this.phoneNumber,
    this.location,
    this.postalCode,
    this.profileImageUrl,
    this.coverImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        fullName: json['fullName'],
        bio: json['bio'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        location: json['location'],
        postalCode: json['postalCode'],
        profileImageUrl: json['profileImageUrl'],
        coverImageUrl: json['coverImageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'bio': bio,
        'email': email,
        'phoneNumber': phoneNumber,
        'location': location,
        'postalCode': postalCode,
        'profileImageUrl': profileImageUrl,
        'coverImageUrl': coverImageUrl,
      };
}
