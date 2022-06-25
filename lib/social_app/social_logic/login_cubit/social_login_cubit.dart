 import 'package:ahmed_new_test/social_app/social_logic/login_cubit/social_login_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import 'user_model.dart';


class SocialLoginCubit extends Cubit<SocialLoginState>{
  SocialLoginCubit():super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);

 late UserModel model;
  Future<void>createUser({required String email,
  required String name,
   required String phone,
    required String image,
    required String cover,

    required String bio,

    required String uId,
    required bool isEmailVerification,
  })async{

   emit(SocialCreateUserLoadingState()) ;
    model =UserModel(coverImage:cover ,email: email, username: name, id: uId, phone: phone,profileImage:image,bio:bio,isEmailVerification:false);
FirebaseFirestore.instance.collection('user').doc(uId).set(model.toMap()).then(
        (value) {emit(SocialCreateUserSuccessState( )) ;
        }).catchError((error){
          print(error.toString());
          emit(SocialCreateUserErrorState(error.toString())) ;
});
}

Future<void> socialRegister({required String email,
    required String name,
    required String password,
    required String phone,

}) async {

    emit(SocialRegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password
   ).then((value) {
      print(value.user?.email);
      //final data = value.data.map((postJson) => LoginModel.fromJson(postJson)).tolist() ;
/*     print(loginData.message);
      print(loginData.status);
      print(loginData.data.token);*/
     createUser(email: email, name: name, phone: phone,
         cover: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlDzUWj5svIi94MEs3S0hBSlFo1vwxeC42vw&usqp=CAU',
         image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCBvSgP1ie8WxVyk4mF2K6ntQOZczdfBm9YA&usqp=CAU',
         bio:'Write your bio...',
         uId: value.user!.uid,
         isEmailVerification: value.user!.emailVerified);


    })
.catchError((error){
  print(error.toString());

  emit(SocialRegisterErrorState(error.toString()));
})
;
  }

  Future<void> socialLogin({required String email,
    required String password}) async {

    emit(SocialLoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
    ).then((value) {
           print(value.user?.uid);
       //final data = value.data.map((postJson) => LoginModel.fromJson(postJson)).tolist() ;
/*     print(loginData.message);
      print(loginData.status);
      print(loginData.data.token);*/

      emit(SocialLoginSuccessState(value.user!.uid ));
    })
.catchError((error){
  print(error.toString());

  emit(SocialLoginErrorState(error.toString()));
})
;
  }


  //todo changePassIcon()خلي بالكككككككككككككككككككككككك وانت بتستدعيهاااااا تكتب الاقواااااس كدا
  //todo changePassIcon مش كدا

  //todo RegisterChangeIcon
  bool isIcon=false;
  IconData suffex=Icons.visibility_outlined;
  void changePassIcon(){

    isIcon=!isIcon;
    suffex= isIcon?Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(SocialChangeIconState());
  }

  //todo RegisterChangeIcon
  bool isRegIcon=false;
  IconData suffexReg=Icons.visibility_outlined;
  void changePassRegIcon(){

    isRegIcon=!isRegIcon;
    suffexReg= isRegIcon?Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(SocialChangeRegisterIconState());
  }


}