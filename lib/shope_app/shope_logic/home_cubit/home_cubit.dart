 import 'package:ahmed_new_test/shope_app/pages/screens/settings_screen.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/category_model.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/change_favorite_model.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/home_model.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/login_cubit/login_model.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../end_points.dart';
import '../../pages/screens/category_screen.dart';
import '../../pages/screens/favorets_screen.dart';
import '../../pages/screens/products_screen.dart';
import '../login_cubit/login_web_services.dart';
import 'favorites_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit():super(HomeInitialState());
  static HomeCubit get(context)=>BlocProvider.of(context);
  
  //todo -----BottomNavBar كل ما يخص ال-------//
 int currentIndex=0;
  List screens =[
    const  ProductsScreen(),
  const CategoryScreen(),
  const FavoritesScreen(),

  const  SettingsScreen()
  ];

  List<BottomNavigationBarItem>bottomItems=[
    const BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Category'),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),

    //  const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
  ];
  void changeBottomNavBar(int index)async{
    currentIndex =index;
    // if(index==1) {
    //  }
    // if(index==2) {
    //  }
   emit( HomeChangeNavBarState());
  }
//-------------------------------------------------------------//

//todo ============getHomeData الميثود اللي هتعرض الداتا بتاعت الهوم=========//
  ShopModel? shopModel;
late  Map<int,bool>favor= {};

  Future<void> getHomeData()async{

    emit(HomeLoadingState());

    LoginWebServices.getData(url: homeUrl, token: token).then((value) {
      shopModel=ShopModel.fromJson(value.data);
   shopModel!.data.products.forEach((element) {favor.addAll({
               element.id:element.inFavorites,
        });
   });
      // print(favor.toString());

      // print(shopModel!.data.products[0].image);
      emit(HomeSuccessState());

    }).catchError((error){

      print(error.toString());
      emit(HomeErrorState(error.toString()));
    });
}
CategoryModel? categoryModel;

//todo ============getCategoryData الميثود اللي هتعرض الداتا بتاعت الهوم=========//
  Future<void> getCategoryData()async{

    emit(HomeLoadingState());

    LoginWebServices.getData(url: categoryUrl, token: token).then((value) {
      categoryModel=CategoryModel.fromJson(value.data) ;

     // print(categoryModel!.data.data[0].image);
      emit(CategorySuccessState());

    }).catchError((error){

      print(error.toString());
      emit(CategoryErrorState(error.toString()));
    });
  }

  //todo ============getChangeFavorData الميثود اللي هتعرض الداتا بتاعت الهوم=========//
  ChangeFavorModel? changeFavorModel;
  Future<void> getChangeFavorData({required int productId})async{
    emit(HomeLoadingState());

favor[productId]=! favor[productId]!;
    emit(ChangeFavorIconSuccessState());

    LoginWebServices.postData(url: favoriteUrl, data: {'product_id':productId,},
        token: token).then((value) {
          changeFavorModel=ChangeFavorModel.fromJson(value.data);
          print(changeFavorModel!.message);
          if(!changeFavorModel!.status)
            {
              favor[productId]=! favor[productId]!;

            }else{
          getFavoriteData();}
      emit(ChangeFavorSuccessState(changeFavorModel!));
    }).catchError((error){
      favor[productId]=! favor[productId]!;

      emit(ChangeFavorErrorState(error)) ;
        });
    
  }

  //todo ============getFavoriteData الميثود اللي هتعرض الداتا بتاعت الهوم=========//
  FavoriteModel? favoriteModel;
  Future<void> getFavoriteData( )async{
    emit(FavoriteLoadingState());

    LoginWebServices.getData(url: favoriteUrl,
         token: token,).then((value) {
      favoriteModel=FavoriteModel.fromJson(value.data);
     // print(favoriteModel!.data!.data[0].product.image.toString());

      emit(FavoriteSuccessState() );

  }) .catchError((error){
    print(error.toString());
    emit(FavoriteErrorState(error.toString()) );

    }) ;
}
  //todo ============getUserData الميثود اللي هتعرض الداتا بتاعت الهوم=========//

  LoginModel? loginModel;

  Future<void> getUserData()async{

    emit(UserLoadingState());

    LoginWebServices.getData(url: profileUrl, token: token).then((value) {
      loginModel=LoginModel.fromJson(value.data);

        print(loginModel!.data.email.toString());

      // print(shopModel!.data.products[0].image);
      emit(UserSuccessState());

    }).catchError((error){

      print(error.toString());
      emit(UserErrorState(error.toString()));
    });
  }
  Future<void> upload({required String email,required String name,required String phone}) async {

    emit(UpdateLoadingState());
    LoginWebServices.putData(url: updateUrl,
      token: token,
      data:{
        "email":email,
        "name":name,
        "phone":phone
      } ,
    ).then((value) {
      //   print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      //final data = value.data.map((postJson) => LoginModel.fromJson(postJson)).tolist() ;
      /*     print(loginData.message);
      print(loginData.status);
      print(loginData.data.token);*/

      emit(UpdateSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());

      emit(UpdateErrorState(error.toString()));
    });
  }

}


/*
late LoginModel loginData;
Future<void> Login({required String email,required String password}) async {

  emit(LoginLoadingState());
  LoginWebServices.postData(url: loginUrl,
    data:{
      "email":email,
      "password":password
    } ,
  ).then((value) {
    //   print(value.data);
    loginData= LoginModel.fromJson(value.data);
    //final data = value.data.map((postJson) => LoginModel.fromJson(postJson)).tolist() ;
    */
/*     print(loginData.message);
      print(loginData.status);
      print(loginData.data.token);*//*


    emit(LoginSuccessState(loginData));
  }).catchError((error){
    print(error.toString());

    emit(LoginErrorState(error.toString()));
  });*/
