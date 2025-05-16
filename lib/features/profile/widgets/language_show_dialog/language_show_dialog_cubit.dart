import 'package:bloc/bloc.dart';
import '../../../../main.dart' show sharedPreferences;
import 'language_show_dialog_state.dart';
import 'package:itsale/core/models/enums/language_event_type.dart';

class LanguageShowDialogCubit extends Cubit<LanguageShowDialogState> {

   LanguageShowDialogCubit() : super(LanguageShowDialogStateInit(selectedLanguage: 'arabic')) {
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final lang = sharedPreferences?.getString("lang") ?? "ar";
    if (lang == "ar") {
      emit(AppLanguageChangeState(languageCode: "ar", selectedLanguage: 'arabic'));
    } else if (lang == "en") {
      emit(AppLanguageChangeState(languageCode: "en", selectedLanguage: 'english'));
    } else {
      emit(AppLanguageChangeState(languageCode: "ar", selectedLanguage: 'arabic'));
    }
  }

  void toggleLanguage(String language) {
    final currentState = state;
    if (currentState is AppLanguageChangeState && currentState.selectedLanguage == language) {
      return; // no change
    }

    if (language == 'arabic') {
      sharedPreferences?.setString('lang', 'ar');
      emit(AppLanguageChangeState(languageCode: "ar", selectedLanguage: 'arabic'));
    } else if (language == 'english') {
      sharedPreferences?.setString('lang', 'en');
      emit(AppLanguageChangeState(languageCode: "en", selectedLanguage: 'english'));
    }
  }
}
