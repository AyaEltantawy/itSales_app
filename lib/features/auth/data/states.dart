abstract class AppStates {}

// General
class InitialState extends AppStates {}
class NoInternetAppState extends AppStates {}
class ChangeButtonState extends AppStates {}
class CheckBoxUpdate extends AppStates {}
class ThemeState extends AppStates {
  final bool isDarkMode;
  ThemeState(this.isDarkMode);
}

// Login States
class PostLoadingLoginSalesState extends AppStates {}
class PostSuccessLoginSalesState extends AppStates {}
class PostErrorLoginSalesState extends AppStates {}

class PostLoadingLoginState extends AppStates {}
class PostSuccessLoginState extends AppStates {}
class PostSuccessVerifyLoginState extends AppStates {}
class PostErrorLoginState extends AppStates {}

// Register States (NEW — you should add these)
class PostLoadingRegisterState extends AppStates {}
class PostSuccessRegisterState extends AppStates {}
class PostErrorRegisterState extends AppStates {}
class NoInternetConnectionState extends AppStates{}
class GetLoadingCompanyState extends AppStates{}
class GetSuccessLocationState extends AppStates{}
class GetErrorCompanyState extends AppStates{}

// OTP States
class PostLoadingOTPState extends AppStates {}
class PostSuccessOTPState extends AppStates {}
class PostErrorOTPState extends AppStates {}

// Verify States
class PostLoadingVerifyState extends AppStates {}
class PostSuccessVerifyState extends AppStates {}
class PostErrorVerifyState extends AppStates {}

// Info States
class GetLoadingInfoState extends AppStates {}
class GetSuccessInfoState extends AppStates {}
class GetErrorInfoState extends AppStates {}

// Favourite States
class PostLoadingFavouriteState extends AppStates {}
class PostSuccessFavouriteState extends AppStates {}
class PostWarningFavouriteState extends AppStates {}
class PostErrorFavouriteState extends AppStates {}

class PostLoadingGetFavouriteState extends AppStates {}
class PostSuccessGetFavouriteState extends AppStates {}
class PostErrorGetFavouriteState extends AppStates {}

class PostLoadingDeleteFavouriteState extends AppStates {}
class PostSuccessDeleteFavouriteState extends AppStates {}
class PostErrorDeleteFavouriteState extends AppStates {}
class GetSuccessCompanyState extends AppStates {}
class PostLoadingAllNotificationState extends AppStates{}
class PostSuccessAllNotificationState extends AppStates{}
class PostErrorAllNotificationState extends AppStates{}
