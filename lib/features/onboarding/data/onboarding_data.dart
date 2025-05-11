import '../../../core/constants/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'إدارة مهامك بسهولة',
      description: 'نقدم لك أداة متكاملة لإدارة وتنظيم مهام فريق السيلز.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'تتبع تقدم فريقك',
      description: 'ابق على اطلاع دائم بأداء فريق السيلز الخاص بك',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'احصل على تقارير دقيقة',
      description: 'يمكنك الآن تحليل البيانات واتخاذ الخطوات اللازمة',
    ),
  ];
}
