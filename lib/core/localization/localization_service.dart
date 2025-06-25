import 'package:flutter/material.dart';
import 'app_localizations.dart';

class LocalizationService {
  static late AppLocalizations _localizations;

  static void init(BuildContext context) {
    _localizations = AppLocalizations.of(context)!;
  }

  static String tr(String key) {
    return _localizations.translate(key);
  }
}
