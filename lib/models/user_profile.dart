class UserProfile {
  const UserProfile({required this.name, required this.email});

  final String name;
  final String email;

  String get avatarInitial {
    final trimmedName = name.trim();
    return trimmedName.isEmpty ? '?' : trimmedName[0].toUpperCase();
  }
}
