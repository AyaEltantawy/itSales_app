import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email Validator
  static final email = EmailValidator(errorText: 'ايميل غير صالح');

  /// Password Validator
  static final password = MultiValidator([
    RequiredValidator(errorText: 'كلمة السر مطلوبة'),
    MinLengthValidator(8, errorText: 'يجب أن تكون كلمة السر ع الأقل 8 أحرف'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'يجب أن يكون هناك رمزا واحدا على الأقل')
  ]);

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String? fieldName) =>
      RequiredValidator(errorText: '${fieldName ?? 'Field'} مطلوب ');

  /// Plain Required Validator
  static final required = RequiredValidator(errorText: 'لا تترك هذا الحقل فارغا');
}
