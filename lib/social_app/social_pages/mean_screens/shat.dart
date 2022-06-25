import 'package:ahmed_new_test/social_app/social_logic/login_cubit/user_model.dart';
 import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_cubit.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_states.dart';
import 'package:ahmed_new_test/social_app/social_pages/mean_screens/shat_details_screen.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShatScreen extends StatefulWidget {
  const ShatScreen({Key? key}) : super(key: key);

  @override
  State<ShatScreen> createState() => _ShatScreenState();
}

class _ShatScreenState extends State<ShatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(builder: (context,state){
        if(SocialCubit.get(context).users.isNotEmpty) {
          return Scaffold(
         body: ListView.separated(

            itemBuilder: (context, index) {
              /* indexes.add(index);
                        for (var element in indexes) {
                          commentControllers.add(TextEditingController());
                        }*/
              return buildShatItem(SocialCubit.get(context).users[index],
             );
            },
            separatorBuilder: (context, index) =>
            const Divider(),

            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount:SocialCubit.get(context).users.length),
      );
        }
        else {return const Center(child: Text('No Frinds',style: TextStyle(fontSize: 30),));}
        }
        , listener:(context,state){} );
  }

  Widget buildShatItem(UserModel model) {
    return InkWell(
      onTap: (){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context)=>  ShatDetailsScreen(userModel: model)/*const Home()*/,
            ), (route) {
          return true;
        });


      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

            Padding(
            padding:const EdgeInsets.all(8.0),
            child: CircleAvatar(

              backgroundImage: NetworkImage( model.profileImage
                 /* model.profileImage*/),
              backgroundColor: Colors.black12,
              radius: 30,

            ),
          ),
          const SizedBox(height: 10,),
          Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.username/*model.username*/, style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 17),),
              const SizedBox(height: 5,),

            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz))


        ],
      ),
    );
  }
}
