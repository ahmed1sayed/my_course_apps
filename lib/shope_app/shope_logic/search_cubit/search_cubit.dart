import 'package:ahmed_new_test/news_app/logic/web_services.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/search_cubit/search_model.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/search_cubit/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../end_points.dart';
import '../login_cubit/login_web_services.dart';

class SearchCubit extends Cubit<SearchStates>{
  @override
  SearchCubit() :super (SearchInitState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? searchModel;
   Future<void>getSearch({String ?text})async{

    emit(SearchLoadingState());

    LoginWebServices.postData(
        url: searchUrl,
        data: {
          'text':text??'' ,
        },
        token: token
    ).then((value){
searchModel=SearchModel.fromJson(value.data);
print(searchModel!.data.data[0].image.toString());
emit(SearchSuccessState());

    }



    )/*.catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    })*/;
  }
}