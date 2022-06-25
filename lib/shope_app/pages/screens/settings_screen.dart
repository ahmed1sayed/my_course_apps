import 'package:ahmed_new_test/widgets.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/home_cubit.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/home_states.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news_app/cache_helper.dart';
import '../../shope_logic/end_points.dart';
 import '../logging/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
           var formKey=GlobalKey< FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {},
      builder: (context, state) {


      if(state is! UserLoadingState){ userNameController.text=HomeCubit.get(context).loginModel!.data.name ;
      phoneController.text=HomeCubit.get(context).loginModel!.data.phone;
      emailController.text=HomeCubit.get(context).loginModel!.data. email;
     return Scaffold(
       body: SingleChildScrollView(

         child: Form(
           key: formKey,

           child: Column(
             children: [
            const   SizedBox(height: 30,),
               defaultFormField(controller: userNameController,
                   type: TextInputType.text,
                   label: 'user name',
                   prefix: Icons.person,validate:(String? validate){
                 if(validate!.isEmpty){
                   return'user name can\'t be empty';
                 }else{return null;}

                   }

               ),
               defaultFormField(controller: phoneController,
                   type: TextInputType.text,
                   label: 'phone number',
                   prefix: Icons.phone,
                   validate:(String? validate){
    if(validate!.isEmpty){
    return'phone can\'t be empty';
    }else{return null;}}
    ),
               defaultFormField(controller: emailController,
                   type: TextInputType.text,
                   label: 'email address',
                   prefix: Icons.person,
                   validate:(String? validate){
                     if(validate!.isEmpty){
                       return'email can\'t be empty';
                     }else{return null;}}),

               const SizedBox(height: 50,),

               CustomButton(title: 'Logout',onTap: ( ){

                   CacheHelper.removeData(key: 'token').then((value){

                     if(value == true) {
                       Navigator.pushAndRemoveUntil(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const LoginScreen() /*const Home()*/,
                           ), (route) {
                         return false;
                       });
                     }
                   }
                   );
               },),
              const SizedBox(height: 15,),
             state is!  UpdateLoadingState?
               CustomButton(onTap: (){
                 if(formKey.currentState!.validate() ){
                   HomeCubit.get(context).upload(email: emailController.text, name:  userNameController.text, phone:  phoneController.text );}

               }, title:'Edit'):const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),),
             ], ),
         ),
       )

       );}else{return
     Center(child: CircularProgressIndicator(color: defaultColor,),);}


    },);
  }
}
