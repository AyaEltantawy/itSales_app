import 'package:bloc/bloc.dart';
import '../../../../core/constants/navigation.dart' as MagicRouter;
import '../../../../main.dart' show sharedPreferences;
import 'language_show_dialog_state.dart';
import 'package:itsale/core/models/enums/language_event_type.dart';

class LanguageShowDialogCubit extends Cubit<LanguageShowDialogState> {
  LanguageShowDialogCubit()
      : super(LanguageShowDialogStateInit(selectedLanguage: 'arabic')) {
    _loadSavedLanguage();
  }

  /// Loads the saved language from shared preferences
  Future<void> _loadSavedLanguage() async {
    final lang = sharedPreferences?.getString("lang") ?? "ar";
    final selected = lang == "ar" ? 'arabic' : 'english';
    if (!isClosed) {
      emit(AppLanguageChangeState(
        languageCode: lang,
        selectedLanguage: selected,
      ));
    }
  }

  /// Changes language and emits the new state
  Future<void> changeLanguage(String languageCode) async {
    await sharedPreferences?.setString('lang', languageCode);
    final selected = languageCode == "ar" ? 'arabic' : 'english';

      emit(AppLanguageChangeState(
        languageCode: languageCode,
        selectedLanguage: selected,
      ));

  }

  /// Public method to handle language events
  Future<void> appLanguageFunc(LanguageEventEnums eventType) async {
    switch (eventType) {
      case LanguageEventEnums.InitialLanguage:
        await _loadSavedLanguage();
        break;
      case LanguageEventEnums.ArabicLanguage:
        await changeLanguage('ar');
        break;
      case LanguageEventEnums.EnglishLanguage:
        await changeLanguage('en');
        break;
    }
  }

  /// (Optional) Toggle language manually — not used in dialog but can help for tests
  Future<void> toggleLanguage() async {
    final currentLang = sharedPreferences?.getString("lang") ?? "ar";
    final newLang = currentLang == "ar" ? "en" : "ar";
    await changeLanguage(newLang);
  }
}
