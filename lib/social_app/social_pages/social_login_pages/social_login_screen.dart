
 import 'package:ahmed_new_test/news_app/cache_helper.dart';
import 'package:ahmed_new_test/widgets.dart';

 import 'package:ahmed_new_test/social_app/social_logic/login_cubit/social_login_states.dart';
import 'package:ahmed_new_test/social_app/social_pages/social_home_screen.dart';
import 'package:ahmed_new_test/social_app/social_pages/social_login_pages/social_ragister_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../social_logic/login_cubit/social_login_cubit.dart';

//dasd@gmail.com
class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  _SocialLoginScreenState createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context,state){
          if(state is SocialLoginErrorState ){Fluttertoast.showToast(
              msg:state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20.0
          );
              }

            if(state is SocialLoginSuccessState){
              Fluttertoast.showToast(
                  msg: 'login successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                fontSize: 16.0 );
            CacheHelper.saveData(key: 'myId', value: state.uId).then((value){
                navigateAndFinish(context: context, method:const SocialHomeScreen());

            });





            }


        },
        builder:(context,state){
          return Scaffold(
            /*            appBar:  AppBar(
             //  toolbarHeight: 70,
            leading: Container(),backgroundColor: Colors.transparent,
            elevation: 0,),*/

            body: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const SizedBox(height: 5,),
                      Center(
                        child: Container(
                          height: 200,
                          width: 360,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(image: AssetImage(
                                'assets/imgs/undraw_Login_re_4vu2.png',),
                              )

                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5, top: 15, left: 5, right: 5),
                        child: Text(' LOGIN', style: Theme
                            .of(context)
                            .textTheme
                            .headline5
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('  login now to make new friends', style: Theme
                            .of(context)
                            .textTheme
                            .headline4
                        ),
                      ),
                      const SizedBox(height: 30,),

                      defaultFormField(controller: emailController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'write your email';
                            }
                            else {
                              return null;
                            }
                          },
                          label: 'email',
                          prefix: Icons.email),


                      defaultFormField(controller: passController,
                          scure:
                          SocialLoginCubit
                              .get(context)
                              .isIcon,
                          suffix: SocialLoginCubit.get(context).suffex,
                          IconOnPressed: () {

                            SocialLoginCubit
                                .get(context)
                                .changePassIcon();
                            print(SocialLoginCubit.get(context).isIcon);
                          },
                          type: TextInputType.text,
                          validate: (String? validate) {
                            if (validate!.isEmpty) {
                              return 'write your password';
                            }
                            else {
                              return null;
                            }
                          },
                          label: 'password',
                          prefix: Icons.lock),

                      //todo Login Button
                      state is! SocialLoginLoadingState?
                      CustomButton( title: 'Login',onTap: ()   {
                        if (formKey.currentState!.validate())  {
                          SocialLoginCubit.get(context).socialLogin(email: emailController.text, password: passController.text );

                        }}
                      ) : const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),),

                      //todo register Button
                      RegisterTxtButton(onPressed: () {
                        normalNavigate(context: context, method: const SocialRegisterScreen());
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );} ,

      ),
    );
  }
}
