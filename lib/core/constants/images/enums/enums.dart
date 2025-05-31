enum Gender { male, female }

enum AvatarState { thinking, success }

extension GenderExtension on Gender {
  String toShortString() {
    return name; // 'male' ou 'female'
  }

  static Gender fromString(String value) {
    return Gender.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Gender.male, // fallback par défaut
    );
  }
}
