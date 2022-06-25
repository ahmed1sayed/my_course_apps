 import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_cubit.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_states.dart';
import 'package:ahmed_new_test/widgets.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {

  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController postTextController=TextEditingController();
  var now=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(  listener:(context,state){},
        builder: (context,state){

          return  Scaffold(
          appBar: postAppbar(title: 'Create Post',
              context: context  ,
              actionTitle: 'Upload',
              actionOnPressed: (){
          if(SocialCubit.get(context).postImage==null){
            SocialCubit.get(context).createNewPost(   postText: postTextController.text, dateTime: now.toString());
          }else{
            SocialCubit.get(context).uploadPostImage(postText: postTextController.text, dateTime:  now.toString());
          }
          Navigator.pop(context);
              }),
          body: Card(
          elevation: 5,
          child: Column(
            children: [
              if(state is SocialCreateNewPostLoadingState)
              const LinearProgressIndicator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(

                      backgroundImage: NetworkImage(
                          SocialCubit.get(context).userModel!.profileImage),
                      backgroundColor: Colors.black12,
                      radius: 25,

                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(SocialCubit.get(context).userModel!.username, style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 17),),
                      const SizedBox(height: 5,),
                        Text(now.toString(), style:const TextStyle(
                          fontSize: 13, color: Colors.black45),),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz))


                ],
              ),
              Expanded(

                 child: SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(7.0),
                     child: Column(
                       children: [
                         TextFormField(
                           minLines: 1,
                             maxLines: 10,
                             controller:postTextController,


                          decoration: const InputDecoration(hintText:'what\'s you mind',
                          border: InputBorder.none ),
                    ),
                       if(SocialCubit.get(context).postImage !=null)
                         Container(
                           height: 300,
                           width: double.infinity,
                           decoration: BoxDecoration(
                               image: DecorationImage(image: FileImage(
                                   SocialCubit.get(context).postImage! ))),)

                         ],
                     ),

                   ),
                 ),
               ),
               Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(child:TextButton(onPressed: (){},child: const Text('# tags'),)),

                  Expanded(child:TextButton(onPressed: (){SocialCubit.get(context).getPostImage();},child: Row(
                    children: const [  Icon(Icons.image),
                      SizedBox(width: 5,),
                      Text('photos')
                    ],
                  ),))],
              )

            ],
          ),
          ),
        );}
      );
  }
}
