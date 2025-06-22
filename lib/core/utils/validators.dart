import 'package:flutter/material.dart' show BuildContext;
import 'package:form_field_validator/form_field_validator.dart';
import 'package:itsale/core/routes/magic_router.dart';

import '../localization/app_localizations.dart';

class Validators  {

  /// Email Validator
  ///
  static EmailValidator email(BuildContext context)  => EmailValidator(errorText: AppLocalizations.of(context)!.translate("invalid_email")
  );

  /// Password Validator
  static MultiValidator password(BuildContext context) =>MultiValidator([
    RequiredValidator(errorText: AppLocalizations.of(context)!.translate("password_required")
    ),
    MinLengthValidator(8, errorText:AppLocalizations.of(context)!.translate("password_min_length")
    ),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'يجب أن يكون هناك رمزا واحدا على الأقل')
  ]);

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String? fieldName,BuildContext context) =>
      RequiredValidator(errorText: '${fieldName ?? 'Field'} ${AppLocalizations.of(context)!.translate("required")
      } ');

  /// Plain Required Validator
  static RequiredValidator required(BuildContext context) => RequiredValidator(errorText: AppLocalizations.of(context)!.translate('Do not leave this field blank.'));
}
