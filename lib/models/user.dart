enum UserRole { attendee, organizer }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final UserRole role;
  final String bio;
  final List<String> interests;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.role,
    this.bio = "",
    this.interests = const [],
  });

  // For persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role.index,
      'bio': bio,
      'interests': interests,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      role: UserRole.values[json['role']],
      bio: json['bio'] ?? "",
      interests: List<String>.from(json['interests'] ?? []),
    );
  }
}
