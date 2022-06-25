import 'package:dio/dio.dart';


class WebServices {
  static late Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(baseUrl: 'https://newsapi.org/',
          receiveDataWhenStatusError: true,
          receiveTimeout: 3*1000,
          connectTimeout: 3*1000,
        )
    );
  }

/*'v2/top-headlines', queryParameters: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }*/
  Future<Response> getData({required String url,required Map<String,dynamic> query}) async {
    //Future.delayed(const Duration(milliseconds: 500), () => dio.get(url,queryParameters: query));
      return await dio.get(url,queryParameters: query);


  }}
// server base url:
//data: v2/top-headlines?
// query: country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca