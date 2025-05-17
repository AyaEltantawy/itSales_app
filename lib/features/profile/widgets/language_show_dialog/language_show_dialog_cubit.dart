import 'package:bloc/bloc.dart';
import '../../../../main.dart' show sharedPreferences;
import 'language_show_dialog_state.dart';
import 'package:itsale/core/models/enums/language_event_type.dart';

class LanguageShowDialogCubit extends Cubit<LanguageShowDialogState> {
  LanguageShowDialogCubit()
      : super(LanguageShowDialogStateInit(selectedLanguage: 'arabic')) {
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final lang = sharedPreferences?.getString("lang") ?? "ar";
    emit(AppLanguageChangeState(
      languageCode: lang,
      selectedLanguage: lang == "ar" ? 'arabic' : 'english',
    ));
  }

  void changeLanguage(String languageCode) {
    sharedPreferences?.setString('lang', languageCode);
    emit(AppLanguageChangeState(
      languageCode: languageCode,
      selectedLanguage: languageCode == "ar" ? 'arabic' : 'english',
    ));
  }

  void appLanguageFunc(LanguageEventEnums eventType) {
    switch (eventType) {
      case LanguageEventEnums.InitialLanguage:
        _loadSavedLanguage();
        break;
      case LanguageEventEnums.ArabicLanguage:
        changeLanguage('ar');
        break;
      case LanguageEventEnums.EnglishLanguage:
        changeLanguage('en');
        break;
    }

  }
  String selectedLanguage ='arabic';
  toggleLanguage(){
    selectedLanguage != selectedLanguage;
    _loadSavedLanguage();
    emit(ToggleLanguage());
  }
}