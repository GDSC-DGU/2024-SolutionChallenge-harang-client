enum Gender { male, female, none }

extension GenderStringExtension on Gender {
  String get genderString {
    switch (this) {
      case Gender.male:
        return "남성";
      case Gender.female:
        return "여성";
      case Gender.none:
        return "상관없음";
      default:
        return "";
    }
  }
}
