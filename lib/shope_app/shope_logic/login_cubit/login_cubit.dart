import 'package:ahmed_new_test/shope_app/shope_logic/login_cubit/login_model.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/login_cubit/login_states.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/login_cubit/login_web_services.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

import '../end_points.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

late LoginModel loginData;
  Future<void> login({required String email,required String password}) async {

    emit(LoginLoadingState());
LoginWebServices.postData(url: loginUrl,
  token: token,
  data:{
  "email":email,
  "password":password
  } ,
    ).then((value) {
   //   print(value.data);
      loginData= LoginModel.fromJson(value.data);
 //final data = value.data.map((postJson) => LoginModel.fromJson(postJson)).tolist() ;
 /*     print(loginData.message);
      print(loginData.status);
      print(loginData.data.token);*/

      emit(LoginSuccessState(loginData));
    })/*.catchError((error){
  print(error.toString());

  emit(LoginErrorState(error.toString()));
})*/;
  }

  Future<void> register({required String email,required String name,required String phone,required String password}) async {

    emit(RegisterLoadingState());
    LoginWebServices.postData(url: registerUrl,
      token: token,
      data:{
        "email":email,
        "password":password,
        "name":name,
        "phone":phone
      } ,
    ).then((value) {
      //   print(value.data);
      loginData= LoginModel.fromJson(value.data);
      //final data = value.data.map((postJson) => LoginModel.fromJson(postJson)).tolist() ;
      /*     print(loginData.message);
      print(loginData.status);
      print(loginData.data.token);*/

      emit(RegisterSuccessState(loginData));
    })/*.catchError((error){
  print(error.toString());

  emit(RegisterErrorState(error.toString()));
})*/;
  }

  //todo changePassIcon()خلي بالكككككككككككككككككككككككك وانت بتستدعيهاااااا تكتب الاقواااااس كدا
  //todo changePassIcon مش كدا

  //todo RegisterChangeIcon
  bool isIcon=false;
  IconData suffex=Icons.visibility_outlined;
  void changePassIcon(){

    isIcon=!isIcon;
    suffex= isIcon?Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(ChangeIconState());
  }

  //todo RegisterChangeIcon
  bool isRegIcon=false;
  IconData suffexReg=Icons.visibility_outlined;
  void changePassRegIcon(){

    isRegIcon=!isRegIcon;
    suffexReg= isRegIcon?Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(ChangeRegisterIconState());
  }


}