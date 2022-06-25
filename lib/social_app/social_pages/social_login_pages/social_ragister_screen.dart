 import 'package:ahmed_new_test/widgets.dart';
import 'package:ahmed_new_test/social_app/social_pages/social_home_screen.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

 import '../../social_logic/login_cubit/social_login_cubit.dart';
import '../../social_logic/login_cubit/social_login_states.dart';

class SocialRegisterScreen extends StatefulWidget {
  const SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  _SocialRegisterScreenState createState() => _SocialRegisterScreenState();
}

class _SocialRegisterScreenState extends State<SocialRegisterScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController nameController=TextEditingController();




  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context,state) {
          if (state is SocialRegisterErrorState) {



            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );


            } else {   Fluttertoast.showToast(
              msg: 'register successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0
          );
                    if(state is SocialCreateUserSuccessState){
                      navigateAndFinish(context: context , method:const SocialHomeScreen ());
                    }
            }

        },
        builder:(context,state){
          return Scaffold(
                        appBar:  AppBar(
             //  toolbarHeight: 70,
                          backgroundColor: Colors.transparent,
             elevation: 0,),

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
                      /* Center(
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
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5, top: 15, left: 5, right: 5),
                        child: Text(' REGISTER', style: Theme
                            .of(context)
                            .textTheme
                            .headline5
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('  Register now to make new friends', style: Theme
                            .of(context)
                            .textTheme
                            .headline4
                        ),
                      ),
                      const SizedBox(height: 30,),
                      defaultFormField(controller: nameController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'write your name';
                            }
                            else {
                              return null;
                            }
                          },
                          label: 'name',
                          prefix: Icons.edit),
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
                              .isRegIcon,
                          suffix: SocialLoginCubit.get(context).suffexReg,
                          IconOnPressed: () {

                            SocialLoginCubit
                                .get(context)
                                .changePassRegIcon();
                            print(SocialLoginCubit.get(context).isRegIcon);
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
                      defaultFormField(controller:phoneController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'write your phone';
                            }
                            else {
                              return null;
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone),


                      //todo register Button
                      state is! SocialRegisterLoadingState?
                      CustomButton( title: 'Register',onTap: ()   {
                        if (formKey.currentState!.validate())  {
                          SocialLoginCubit.get(context).socialRegister(
                          email: emailController.text,
                           password: passController.text,
                              phone: phoneController.text, name: nameController.text);
                         /* normalNavigate(context: context, method: const SocialLoginScreen());*/
                        }}
                      ) : const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),),

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
