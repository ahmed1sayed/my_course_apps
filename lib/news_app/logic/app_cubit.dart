
 import 'package:ahmed_new_test/news_app/logic/web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cache_helper.dart';
import '../pages/bisness_screen.dart';
import '../pages/science_screen.dart';
import '../pages/sport_screen.dart';
import 'app_states.dart';
class AppCubit extends Cubit<AppStates>{
  AppCubit():super(NewsGetBusinessLoadingState());
  static AppCubit get(context)=>BlocProvider.of(context);

  //todo الجزء بتاع التنقل في النفيجيتور بار
  int currentindex=0;
  List screens= [
    const BisnessScreen(),
    const SportScreen(),
    const ScienceScreen(),
   // const SettingsScreen(),
  ];

  List<BottomNavigationBarItem>bottomItems=[
   const BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sport'),
    const BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
  //  const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
  ];
  //todo تعبئة الجيت بتاعت الدايو
  List<dynamic>business=[];
  List<dynamic>sports=[];
  List<dynamic>science=[];
  List<dynamic>search=[];

  void getBusiness()async{
await
WebServices().getData(url: 'v2/top-headlines', query: {
  "country":"eg",
'category':'business',
'apiKey':'6732781d42fd4231a186519cabf79dbc',

}).then((value) {

  business=value.data['articles'];
  emit(NewsGetBusinessSuccessState());
}).catchError((error){

  // ignore: avoid_print
  print(error.toString());
emit(NewsBusinessErrorState(error: error.toString()));
});

}
  void getSport()async{

   await WebServices().getData(url: 'v2/top-headlines', query: {
      "country":"eg",
      'category':'sports',
      'apiKey':'6732781d42fd4231a186519cabf79dbc',

    }).then((value) {

      sports=value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error){

      // ignore: avoid_print
      print(error.toString());
      emit(NewsSportsErrorState(error: error.toString()));
    });

  }
  void getScience()async{
await
    WebServices().getData(url: 'v2/top-headlines', query: {
      "country":"eg",
      'category':'science',
      'apiKey':'6732781d42fd4231a186519cabf79dbc',

    }).then((value) {

      science=value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){

      // ignore: avoid_print
      print(error.toString());
      emit(NewsScienceErrorState(error: error.toString()));
    });

  }
  //todo  الجيت بتاعت ليستة السيرش
  void getSearch({String ? value})async{
    emit(NewsGetSearchLoadingState());
    WebServices().getData(url: 'v2/top-headlines',
        query: {
      "q":"$value",

      'apiKey':'6732781d42fd4231a186519cabf79dbc',

    }).then((value) {

      search=value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){

      // ignore: avoid_print
      print(error.toString());
      emit(NewsSearchErrorState(error: error.toString()));
    }); }


  //todo  الزراير المتغيرة

   void changeBottomNavBar(int index)async{
    currentindex =index;
    if(index==0) {
      getBusiness();
    }
    if(index==1) {
      getSport();
    }
    if(index==2) {
      getScience();
    }
    emit(NewsBottomBarState());
  }



  bool? isDark=false;
  void changeTheme({bool? fromShared}) {
    if(fromShared !=null){  isDark=fromShared;

    emit(ChangeBottomNavBarState());
    }
  else {
      isDark = !isDark!;
      CacheHelper.saveData(key: 'isDark', value: isDark!).then((value) {
        emit(ChangeBottomNavBarState());
      });
    }
  }
}