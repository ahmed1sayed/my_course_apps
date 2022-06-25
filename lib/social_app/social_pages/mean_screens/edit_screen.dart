

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shope_app/shope_logic/end_points.dart';
import '../../../widgets.dart';
import '../../social_logic/social_cubit/social_cubit.dart';
import '../../social_logic/social_cubit/social_states.dart';
class EditScreen extends StatefulWidget {

  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController nameController=TextEditingController();
   TextEditingController bioController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<SocialCubit,SocialState>(builder: (context,state){
       var cubit=SocialCubit.get(context);
        var userModel= SocialCubit.get(context).userModel;
       nameController.text  =userModel!.username;
      bioController.text =userModel.bio;

       return state is ! SocialLoadingState?
       Scaffold(
         appBar: postAppbar(title: 'Edit Profile', context: context  ,
             actionTitle: 'Update',actionOnPressed: (){

               SocialCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text, bio: bioController.text);
             }),
         body: SingleChildScrollView(
           child: Column(

               children: [if(state is SocialUpdateLoadingState)
                 const LinearProgressIndicator(color: Colors.blueGrey,),
                 SizedBox(height: 250,
                   child: Stack(alignment: AlignmentDirectional.topCenter,
                     children: [
                         Container(
                         height: 180,
                          decoration: BoxDecoration(
                           image:DecorationImage(image:cubit.coverImage==null?
                           NetworkImage(userModel.coverImage) : FileImage(cubit.coverImage!) as ImageProvider<Object> ,
                            fit: BoxFit.cover)

                         ),
                       ),/*Image(image: FileImage(cubit.cover!)),*/
                       Positioned(top: 5,
                           right: 5,
                           child: CircleAvatar(
                         radius: 18,
                         backgroundColor: defaultColor,
                           child: IconButton(onPressed: ( ){cubit.getCoverImage();},
                               icon: const Icon(Icons.camera_alt_outlined,size: 19,)))
                       ),
                       Positioned(bottom: 0,
                         child: CircleAvatar(
                           backgroundColor: Colors.white70,
                           radius: 70,
                           child:  CircleAvatar(

                             backgroundImage:cubit.profileImage==null?
                             NetworkImage(userModel.profileImage) : FileImage(cubit.profileImage!) as ImageProvider<Object> ,

                             backgroundColor: Colors.black12,
                             radius: 65,

                           ) ,
                         ),
                       ),
                       Positioned(bottom: 5,
                           right: 130,
                           child: CircleAvatar(
                               radius: 16,
                               backgroundColor: defaultColor,
                               child: IconButton(onPressed: ( ){cubit.getProfileImage();},
                                   icon: const Icon(Icons.camera_alt_outlined,size: 17,)))
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(height: 15,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                          if(cubit.profileImage!=null)
                     Expanded(

                       child: Column(
                         children: [
                           CustomButton(onTap: ( ){cubit.uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);},
                               title: 'UPLOAD PROFILE',
                           height: 35,
                             width: 165,
                             fontSize: 15
                           ),
                             if(state is SocialUpdateLoadingState)
                               const SizedBox(height: 2,),
                           if(state is SocialUpdateLoadingState)

                           const LinearProgressIndicator()
                         ],
                       ),
                     ),
                     const SizedBox(width: 2,),
                       if(cubit.coverImage!=null)

                     Expanded(

                       child: Column(
                         children: [
                           CustomButton(onTap: ( ){cubit.uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);},
                               title: 'UPLOAD COVER',
                               height: 35,
                               width: 165,
                               fontSize: 15
                           ),
                           if(state is SocialUpdateLoadingState)
                             const SizedBox(height: 2,),
                           if(state is SocialUpdateLoadingState)

                             const LinearProgressIndicator(color: Colors.blueGrey,)

                         ],
                       ),
                     ),
                   ],),

                 const SizedBox(height: 5,),
                 defaultFormField(controller: nameController,
                     type:TextInputType.text , label:'name',
                     validate:  (String? value){
                         if(value!.isEmpty){
                           return 'name must not be empty';
                         }
                         return null;
                     },
                     prefix: Icons.edit,
                     suffix:Icons.person_outline ),
                 defaultFormField(controller: bioController,
                     type:TextInputType.text , label:'bio',
                     validate:  (String? value){
                       if(value!.isEmpty){
                         return 'bio must not be empty';
                       }
                       return null;

                     },
                     prefix: Icons.edit,

                     suffix:Icons.info_outline ),
                 defaultFormField(controller: phoneController,
                     type:TextInputType.text , label:'phone',
                     validate:  (String? value){
                       if(value!.isEmpty){
                         return 'phone number must not be empty';
                       }
                       return null;

                     },
                     prefix: Icons.edit,

                     suffix:Icons.phone_android ),
               ]

           ),
         ),
       ):
       Center(child: CircularProgressIndicator(
            color:defaultColor,
             )
          )
        ;
      }, listener: (context,state){

      }
      )
    ;
  }
}
