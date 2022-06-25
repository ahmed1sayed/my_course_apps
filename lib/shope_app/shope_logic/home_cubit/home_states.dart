import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/change_favorite_model.dart';

import '../login_cubit/login_model.dart';

abstract class HomeState{}
//todo===========HomeStates=============//

class HomeInitialState extends HomeState{}
class HomeLoadingState extends HomeState{}
class HomeSuccessState extends HomeState{}
class HomeErrorState extends HomeState{
  final String error;

  HomeErrorState(this.error);
}
class HomeChangeNavBarState extends HomeState{}

//todo===========CategoryStates=============//
class CategorySuccessState extends HomeState{

}
class CategoryErrorState extends HomeState{
  final String error;

  CategoryErrorState(this.error);
}
//todo===========CategoryStates=============//

class ChangeFavorIconSuccessState extends HomeState {}
class ChangeFavorSuccessState extends HomeState{
 final ChangeFavorModel? model;

 ChangeFavorSuccessState(this.model);
}
class ChangeFavorErrorState extends HomeState{
  final String error;

  ChangeFavorErrorState(this.error);
}
//todo===========CategoryStates=============//
class FavoriteLoadingState extends HomeState{}
class FavoriteSuccessState extends HomeState{}
class FavoriteErrorState extends HomeState{
  final String error;

  FavoriteErrorState(this.error);
}

//todo===========CategoryStates=============//
class UserLoadingState extends HomeState{}
class UserSuccessState extends HomeState{}
class UserErrorState extends HomeState{
  final String error;

  UserErrorState(this.error);
}
//todo UPDATEsStates

class UpdateLoadingState extends HomeState{}
class UpdateSuccessState extends HomeState{
  final LoginModel loginData;

  UpdateSuccessState(this.loginData);
}
class UpdateErrorState extends HomeState{
  final String error;

  UpdateErrorState(this.error);
}
