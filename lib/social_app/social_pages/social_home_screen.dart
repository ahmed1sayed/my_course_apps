import 'package:ahmed_new_test/widgets.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_cubit.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_states.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mean_screens/post.dart';

class SocialHomeScreen extends StatefulWidget {

  const SocialHomeScreen({Key? key}) : super(key: key);

  @override
  _SocialHomeScreenState createState() => _SocialHomeScreenState();
}

class _SocialHomeScreenState extends State<SocialHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(listener:( context,state){
      if(state is NewsNewPostState){
        normalNavigate(context: context, method: const PostScreen());
      }


    }, builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          title: Text(SocialCubit.get(context).title[SocialCubit.get(context).currentindex]
          ),actions: [IconButton(onPressed: ( ){}, icon: const Icon(Icons.notification_important_outlined)),
          IconButton(onPressed: ( ){}, icon: const Icon(Icons.search)
          )
        ],

        ),
        body:SocialCubit.get(context).screens[SocialCubit.get(context).currentindex],
      bottomNavigationBar:   BottomNavigationBar(
        items: SocialCubit.get(context).bottomItems,
        currentIndex: SocialCubit.get(context).currentindex,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
         onTap: (index) {
          // print('index ='+index.toString());
          // print('current index ='+SocialCubit.get(context).currentindex.toString());

          SocialCubit.get(context).changeBottomNavBar(index );
        },
      ),);

    });
  }
}
