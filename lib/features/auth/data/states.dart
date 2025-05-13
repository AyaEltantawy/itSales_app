abstract class AppStates{}
class InitialState extends AppStates{

}



class PostLoadingLoginSalesState extends AppStates{}
class PostSuccessLoginSalesState extends AppStates{}
class PostErrorLoginSalesState extends AppStates{}
class CheckBoxUpdate extends AppStates{}

  class ThemeState extends AppStates{
    final bool isDarkMode;
    ThemeState(this.isDarkMode);
  }


class GetLoadingInfoState extends AppStates{}
class GetSuccessInfoState extends AppStates{}
class GetErrorInfoState extends AppStates{}

class ChangeButtonState extends AppStates{}

class NoInternetAppState extends AppStates{}


class PostLoadingLoginState extends AppStates{}
class PostSuccessLoginState extends AppStates{}
class PostSuccessVerifyLoginState extends AppStates{}
class PostErrorLoginState extends AppStates{}



class PostLoadingOTPState extends AppStates{}
class PostSuccessOTPState extends AppStates{}
class PostErrorOTPState extends AppStates{}

class PostLoadingVerifyState extends AppStates{}
class PostSuccessVerifyState extends AppStates{}
class PostErrorVerifyState extends AppStates{}


class PostLoadingFavouriteState extends AppStates{}
class PostSuccessFavouriteState extends AppStates{}
class PostErrorFavouriteState extends AppStates{}
class PostWarningFavouriteState extends AppStates{}



class PostLoadingGetFavouriteState extends AppStates{}
class PostSuccessGetFavouriteState extends AppStates{}
class PostErrorGetFavouriteState extends AppStates{}

class PostLoadingDeleteFavouriteState extends AppStates{}
class PostSuccessDeleteFavouriteState extends AppStates{}
class PostErrorDeleteFavouriteState extends AppStates{}


