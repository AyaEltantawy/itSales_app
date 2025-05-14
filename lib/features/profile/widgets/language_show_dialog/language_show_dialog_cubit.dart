import 'package:bloc/bloc.dart';

import 'language_show_dialog_state.dart';

class LanguageShowDialogCubit extends Cubit<LanguageShowDialogState> {
  LanguageShowDialogCubit() : super(LanguageShowDialogStateInit());
  String selectedLanguage = 'arabic'; // Default language is Arabic

  // Function to change the selected language
  void toggleLanguage(String language) {
    selectedLanguage = language;
    emit(ToggleLanguage());
  }
  // appLanguageFunc(LanguageEventEnums eventType) {
  //   switch (eventType) {
  //     case LanguageEventEnums.InitialLanguage:
  //       if (sharedPreferences!.getString("lang") != null) {
  //         if (sharedPreferences!.getString("lang") == "ar") {
  //           emit(AppLanguageChangeState(languageCode: "ar"));
  //         }
  //         if (sharedPreferences!.getString("lang") == "en") {
  //           emit(AppLanguageChangeState(languageCode: "en"));
  //         }
  //       }
  //       break;
  //     case LanguageEventEnums.ArabicLanguage:
  //       sharedPreferences!.setString('lang', 'ar');
  //       emit(AppLanguageChangeState(languageCode: "ar"));
  //     case LanguageEventEnums.EnglishLanguage:
  //       sharedPreferences!.setString('lang', 'en');
  //       emit(AppLanguageChangeState(languageCode: "en"));
  //   }
}
