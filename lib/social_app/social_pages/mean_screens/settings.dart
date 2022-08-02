import 'package:ahmed_new_test/social_app/social_pages/mean_screens/edit_screen.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets.dart';
import '../../../../shope_app/shope_logic/end_points.dart';
import '../../social_logic/social_cubit/social_cubit.dart';
import '../../social_logic/social_cubit/social_states.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(builder: (context,state){
     var userModel= SocialCubit.get(context).userModel;
      return /*userModel!=null&&*/ state is ! SocialLoadingState? SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: 250,
                child: Stack(alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      height: 180,
                       decoration: BoxDecoration(image:DecorationImage( image:
                       NetworkImage(userModel!.coverImage)  ,
                           fit: BoxFit.cover)),
                    ),
                         Positioned(bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 70,
                        child: CircleAvatar(

                          backgroundImage: NetworkImage(userModel.profileImage
                             ),
                          backgroundColor: Colors.black12,
                          radius: 65,

                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),

              Center(child: Text(userModel.username,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black87),),),
              const SizedBox(height: 10,),
                Center(child: Text( userModel.bio,style: const TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w400),textAlign:TextAlign.center , ),),
              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(height: 50,
                  width: 50,
                  child: Column(children: const [
                    Text('posts'),
                    Text('200')
                  ],
                  ),
                ),
                SizedBox(height: 50,
                  width: 50,
                  child: Column(children: const [
                    Text('data'),
                    Text('200')
                  ],
                  ),
                ),
                SizedBox(height: 50,
                  width: 50,
                  child: Column(children: const [
                    Text('data'),
                    Text('150')
                  ],
                  ),
                ),
                SizedBox(height: 50,
                  width: 50,
                  child: Column(children: const [
                    Text('data'),
                    Text('600')
                  ],
                  ),
                ),

              ],),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ SizedBox(width: 275,
                child: OutlinedButton(

                   onPressed: (){
                  /*  if(formKey.currentState!.validate() ){
                    HomeCubit.get(context).upload(email: emailController.text, name:  userNameController.text, phone:  phoneController.text );}
*/
                },  child: const Text('Upload photo'),),
              ),
                SizedBox(width: 60,
                  child: OutlinedButton(onPressed: (){
                    navigateTo(context, const EditScreen());
                   }, child: const Icon(Icons.edit,size: 20,),),
                ),],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ SizedBox(width: 180,
                  child: OutlinedButton(

                    onPressed: (){
                       FirebaseMessaging.instance.subscribeToTopic('announcements');
                    },  child: const Text('SUBSCRIBE'),),
                ),
                  SizedBox(width: 180,
                    child:  OutlinedButton(

                      onPressed: (){
                        FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

                      },  child: const Text('UNSUBSCRIBE'),),
                  ),],),


            ]

        ),
      ):
      Center(child: CircularProgressIndicator(color:defaultColor,));
    }, listener: (context,state){} );
  }
}
