import 'login_model.dart';

abstract class LoginState{}
//todo LoginStates

class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
   final LoginModel loginData;

  LoginSuccessState(this.loginData);
}
class LoginErrorState extends LoginState{
  final String error;

  LoginErrorState(this.error);
}
class ChangeIconState extends LoginState{}
//todo RegisterStates

 class RegisterLoadingState extends LoginState{}
class RegisterSuccessState extends LoginState{
  final LoginModel loginData;

  RegisterSuccessState(this.loginData);
}
class RegisterErrorState extends LoginState{
  final String error;

  RegisterErrorState(this.error);
}
class ChangeRegisterIconState extends LoginState{}


