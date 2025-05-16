abstract class LanguageShowDialogState {}

class LanguageShowDialogStateInit extends LanguageShowDialogState {
  final String selectedLanguage;
  LanguageShowDialogStateInit({required this.selectedLanguage});
}

class AppLanguageChangeState extends LanguageShowDialogState {
  final String languageCode;
  final String selectedLanguage;

  AppLanguageChangeState({required this.languageCode, required this.selectedLanguage});
}
