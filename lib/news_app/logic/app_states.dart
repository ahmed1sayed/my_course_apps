
abstract class AppStates{}
class LoadedState extends AppStates{}
class NewsBottomBarState extends AppStates{}

class NewsGetBusinessLoadingState extends AppStates{}
class NewsGetBusinessSuccessState extends AppStates{}
class NewsBusinessErrorState extends AppStates{
  late final String error;

  NewsBusinessErrorState({required this.error});
}

class NewsGetSportsLoadingState extends AppStates{}
class NewsGetSportsSuccessState extends AppStates{}

class ChangeBottomNavBarState extends AppStates{}

class NewsSportsErrorState extends AppStates{
  late final String error;

  NewsSportsErrorState({required this.error});
}


class NewsGetScienceLoadingState extends AppStates{}
class NewsGetScienceSuccessState extends AppStates{}
class NewsScienceErrorState extends AppStates{
  late final String error;


  NewsScienceErrorState({required this.error});
}

class NewsGetSearchLoadingState extends AppStates{}
class NewsGetSearchSuccessState extends AppStates{}
class NewsSearchErrorState extends AppStates{
  late final String error;


  NewsSearchErrorState({required this.error});
}