class LanguageModel {
  String language;
  String subLanguage;
  String languageCode;
  LanguageModel({
    required this.language,
    required this.subLanguage,
    required this.languageCode,
  });
}

List<LanguageModel> get languageModel => [
      LanguageModel(
        language: 'English',
        subLanguage: 'English',
        languageCode: 'en',
      ),
      LanguageModel(
        language: 'ไทย',
        subLanguage: 'Thai',
        languageCode: 'th',
      ),
    ];
