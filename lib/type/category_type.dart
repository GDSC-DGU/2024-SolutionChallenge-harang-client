enum HelpCategory {
  realEstate,
  life,
  medical,
  education,
  companion,
  counseling,
  law,
  labor,
  etc,
}

extension CategoryNameExtension on HelpCategory {
  String get categoryName {
    switch (this) {
      case HelpCategory.realEstate:
        return "부동산";
      case HelpCategory.life:
        return "생활";
      case HelpCategory.medical:
        return "의료";
      case HelpCategory.education:
        return "교육";
      case HelpCategory.companion:
        return "동행";
      case HelpCategory.counseling:
        return "상담";
      case HelpCategory.law:
        return "법";
      case HelpCategory.labor:
        return "근로";
      case HelpCategory.etc:
        return "기타";
      default:
        return "";
    }
  }
}
