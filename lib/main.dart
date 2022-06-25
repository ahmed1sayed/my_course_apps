 import 'dart:io';

import 'package:ahmed_new_test/news_app/themes.dart';
  import 'package:ahmed_new_test/shope_app/shope_logic/end_points.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/home_cubit.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/login_cubit/login_web_services.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/search_cubit/search_cubit.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_cubit.dart';
import 'package:ahmed_new_test/social_app/social_pages/social_home_screen.dart';
import 'package:ahmed_new_test/social_app/social_pages/social_login_pages/social_login_screen.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'native_code.dart';
import 'news_app/cache_helper.dart';
import 'news_app/logic/app_cubit.dart';
import 'news_app/logic/app_states.dart';
import 'news_app/logic/web_services.dart';
import 'news_app/pages/home_page.dart';
/* echo "# udmy_responsive" >> README.md
 git init
 git add README.md
 git commit -m "first commit"
 git branch -M main
 git remote add origin https://github.com/ahmed1sayed/udmy_responsive.git
 git push -u origin main
hel000000000000
 1.check out master
 2.update master
 3.create branch
 4.code....
 5.commit or commit&&push
6.check out master
7.update master
8.check out your local branch
9.check out master
10.push
abdooo
helloomeeeeeeeeeeeeaaaaaaaaaaaaaaaaaaaww

 */

 Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   // If you're going to use other Firebase services in the background, such as Firestore,
   // make sure you call `initializeApp` before using other Firebase services.

   print("+++++++++++++++++++++++Handling a background message: ${message.data.toString()}");
 }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isWindows){
    await DesktopWindow.setMinWindowSize(const Size(350,350));
  }
 /*  await Firebase.initializeApp();
   var token= await FirebaseMessaging.instance.getToken();
   print('=================+++++++++'+token!);
  //todo لو البرنامج مفتوح عادي وجالك اشعار

  FirebaseMessaging.onMessage.listen((event) {
    print('clooooooose'+event.data.toString());
  });
  //todo لو البرنامج شغال في الباك جراوند ودوست عالاشعار هيدخلك عالابليكيشن
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('ooooopen'+event.data.toString());
  });
  //====================================================
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //====================================================
  FirebaseMessaging messaging= FirebaseMessaging.instance;
NotificationSettings settings=await messaging.requestPermission(
  alert: true,
  announcement: false,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true
);
print('user granted permission: ${settings.authorizationStatus}');*/
/*  Bloc.observer=MyBlocObserver();*/
  WebServices.init();
  LoginWebServices.init();
  await CacheHelper.init();
  Widget? widget;
bool? isDark=CacheHelper.getData(key: 'isDark');
  //bool onBoarding=CacheHelper.getData(key: 'onBoarding')!=null;

    // token=CacheHelper.getData(key: 'token')??'null';

   uId=CacheHelper.getData(key: 'myId')??"" ;
if(uId != ''){
  widget =const SocialHomeScreen();
}else{
  widget=const SocialLoginScreen();
}
  // print(token);
     /*if(onBoarding ){
    if(token !='null'){widget= const ShopHomeScreen();
    }else{
      widget= const LoginScreen();
    }
  }else{
    print(onBoarding);
    widget= const OnBoardingScreen();
  }*/
  runApp(  MyApp( isDark: isDark, startingWidget: widget,/*onBoarding: onBoarding,*/));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.isDark,required this.startingWidget, /*  required this.onBoarding*/}) : super(key: key);
final bool? isDark;
  // final bool  onBoarding;
  final   Widget? startingWidget ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

     providers: [

       BlocProvider(
         create: (BuildContext context)=>SocialCubit()..getData()..getPosts() ,
       ),
        BlocProvider(
        create: (BuildContext context)=>AppCubit()..getBusiness()..getSearch(),
        ),
       BlocProvider(
         create: (BuildContext context)=>SearchCubit()..getSearch(),
       ),
      /*  BlocProvider(
        create: (BuildContext context)=>AppCubit()..changeTheme(fromShared: isDark!),),*/
       BlocProvider(create: (BuildContext context)=>HomeCubit()..getHomeData()..getCategoryData()..getFavoriteData()..getUserData()
       )
     ],
      /*child: BlocProvider(
        create: (BuildContext context)=>AppCubit()..getBusiness()..changeTheme(fromShared: isDark!),*/
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
            },
            builder: (context, state) {
              return MaterialApp(

              themeMode:AppCubit.get(context).isDark!? ThemeMode.dark:ThemeMode.light,
                debugShowCheckedModeBanner: false,

                title: 'work shop',
                theme:lightTheme,
                darkTheme: darkTheme,
                home: const NativeCode()
                /*const SocialLoginScreen()startingWidget*/ ,
              );
            }
        ),

    );
  }
}

//todo the main of todo app
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:splash/bloc/cubit.dart';
import 'package:splash/bloc/states.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:Home(),


    );
    //)
    // );
  }
}


// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController titleController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController timeController=TextEditingController();

  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   createDatabase();
  // }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (BuildContext context)=>TasksCubit()..createDatabase() ,
      child: BlocConsumer<TasksCubit,States>(
        listener:(BuildContext context,state){
          if(state is InsertDatabaseState){Navigator.pop(context);}
        } ,
        builder:(BuildContext context,state){TasksCubit cubit= TasksCubit.get(context);
        return
          Scaffold(
            key: scaffoldKey,
            appBar: AppBar(),
            body: cubit.screen[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.isBottomSheet) {

                  if(formKey.currentState!.validate()) {
                    cubit.insertDatabase(title: titleController.text,
                        date: dateController.text,
                        time: timeController.text
                    );
                  }
                }else{  scaffoldKey.currentState!.showBottomSheet((context) {
                  return   Form(
                    key: formKey,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[ Padding(
                          padding: const EdgeInsets.only(right: 20,top: 15.0, bottom: 15.0,left: 50),
                          child: TextFormField(
                            controller: titleController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'VALUE CAN NOT BE EMPTY';
                              }else{return null;}
                            },
                            decoration: const InputDecoration(
                              labelText: "Title ",
                              prefixIcon: Icon( Icons.title,),
                            ),


                          ),

                        ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20,top: 15.0, bottom: 15.0,left: 50),
                            child: TextFormField(
                              controller: timeController,
                              onTap:(){
                                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) => timeController.text=value!.format(context).toString()
                                );
                              } ,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'VALUE CAN NOT BE EMPTY';
                                }else{return null;}
                              },
                              decoration: const InputDecoration(
                                labelText: "Time ",
                                prefixIcon: Icon( Icons.watch_later_outlined,),
                              ),


                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20,top: 15.0, bottom: 15.0,left: 50),
                            child: TextFormField(
                              controller: dateController,
                              onTap: (){
                                showDatePicker(context: context, initialDate: DateTime.now(), firstDate:  DateTime.now(), lastDate: DateTime.parse("2022-03-08")).then((value) {
                                  dateController.text=DateFormat().add_yMMMd().format((value)as DateTime);

                                });
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'VALUE CAN NOT BE EMPTY';
                                }else{return null;}
                              },
                              decoration: const InputDecoration(
                                labelText: "Date ",
                                prefixIcon: Icon( Icons.date_range,),
                              ),


                            ),

                          ),


                        ]
                    ),
                  );
                }).closed.then((value){   cubit.changeButton(isShow: false, icon: Icon(Icons.edit));
                titleController.clear();
                timeController.clear();
                dateController.clear();
                  // setState(() {
                  //   fIcon = Icon(Icons.edit);
                  //
                  // });
                });
                cubit.changeButton(isShow: true, icon: Icon(Icons.add));
                  // setState(() {
                  //   fIcon=Icon(Icons.add);
                  // });

                }

              },
              child: cubit.fIcon,),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,

              onTap: (index){
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu),label:'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline),label:'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label:'Archived'),
              ],
            ),
          ); }  ,
      ),
    );

  }

}



*/
//-------------------------------------------------------------//
