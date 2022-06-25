 import 'package:ahmed_new_test/news_app/cache_helper.dart';
 import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets.dart';
import '../shope_logic/home_cubit/home_cubit.dart';
import 'logging/login_screen.dart';
import 'screens/search_screen.dart';

class ShopHomeScreen extends StatefulWidget {

   const ShopHomeScreen({Key? key}) : super(key: key);

   @override
   _ShopHomeScreenState createState() => _ShopHomeScreenState();
 }

 class _ShopHomeScreenState extends State<ShopHomeScreen> {
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<HomeCubit,HomeState>(listener: (context,state){} ,
         builder: ( context,state){
      var cubit=HomeCubit.get(context);
       return Scaffold(
         appBar: AppBar(
             leading: IconButton(
               icon: const Icon(Icons.search),
               onPressed: (){normalNavigate(context: context,method:const  SearchScreen() );},),
             ),
         bottomNavigationBar: BottomNavigationBar(
        items: cubit.bottomItems,
           onTap: (index){cubit.changeBottomNavBar(index);},
           currentIndex: cubit.currentIndex,
           elevation: 20,
           selectedItemColor: Colors.blueGrey,
           type:BottomNavigationBarType.fixed ,
           ),
           body: cubit.screens[cubit.currentIndex],);
     }
     );
   }
 }
