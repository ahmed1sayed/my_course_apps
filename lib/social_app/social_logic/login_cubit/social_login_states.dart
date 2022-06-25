

abstract class SocialLoginState{}
//todo LoginStates
//todo ALT+jعشان تحدد نفس الاسم في كله
class SocialLoginInitialState extends SocialLoginState{}
class SocialLoginLoadingState extends SocialLoginState{}
class SocialLoginSuccessState extends SocialLoginState{
  late String uId;

  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends SocialLoginState{
  final String error;

  SocialLoginErrorState(this.error);
}
class SocialChangeIconState extends SocialLoginState{}
//todo RegisterStates

class SocialRegisterLoadingState extends SocialLoginState{}
class SocialRegisterSuccessState extends SocialLoginState{

 }
class SocialRegisterErrorState extends SocialLoginState{
  final String error;

  SocialRegisterErrorState(this.error);
}
class SocialChangeRegisterIconState extends SocialLoginState{}

//todo CreateUser

class SocialCreateUserLoadingState extends SocialLoginState{}
class SocialCreateUserSuccessState extends SocialLoginState{


}
class SocialCreateUserErrorState extends SocialLoginState{
  final String error;

  SocialCreateUserErrorState(this.error);
}



