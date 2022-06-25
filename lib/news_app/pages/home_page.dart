 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/app_cubit.dart';
import '../logic/app_states.dart';
import '../search/search.dart';
import '../../widgets.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) { },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(

          appBar: AppBar(
          actions: [
            IconButton(onPressed: ( ){navigateTo(context,const SearchScreen());}, icon: const Icon(Icons.search)),
            IconButton(onPressed: ( ){cubit.changeTheme( );}, icon: const Icon(Icons.brightness_4_outlined))],
          title:  const Text('News App'),

        ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentindex,
            elevation: 20,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),

          body: cubit.screens[cubit.currentindex],
        );
      },
    );
  }
}


