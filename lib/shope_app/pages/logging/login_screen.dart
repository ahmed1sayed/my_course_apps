import 'package:ahmed_new_test/news_app/cache_helper.dart';
import 'package:ahmed_new_test/widgets.dart';
import 'package:ahmed_new_test/shope_app/pages/logging/register_screen.dart';
 import 'package:ahmed_new_test/shope_app/pages/shope_home_screen.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shope_logic/end_points.dart';
import '../../shope_logic/login_cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
          listener: (context,state){
if(state is LoginSuccessState){
  if(state.loginData.status) {
    Fluttertoast.showToast(
        msg: state.loginData.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0
    );
    CacheHelper.saveData(key: 'token', value: state.loginData.data.token).then((
        value) {
      token= state.loginData.data.token;
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => const ShopHomeScreen() /*const Home()*/,
          ), (route) {
            return false;
          });
    } );
  }else{Fluttertoast.showToast(
      msg:state.loginData.message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );

  }
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
                         child: Text('  login now to browse our hot offers', style: Theme
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
                           LoginCubit
                               .get(context)
                               .isIcon,
                           suffix: LoginCubit.get(context).suffex,
                          IconOnPressed: () {

                            LoginCubit
                                .get(context)
                                .changePassIcon();
                            print(LoginCubit.get(context).isIcon);
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
                      state is! LoginLoadingState?
                         CustomButton( title: 'Login',onTap: ()   {
                           if (formKey.currentState!.validate())  {




                        LoginCubit.get(context).login(email: emailController.text, password: passController.text);

                            }}
                           ) : const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),),

                       //todo register Button
                       RegisterTxtButton(onPressed: () {
                         normalNavigate(context: context, method: const RegisterScreen());
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
