import 'package:dio/dio.dart';

class LoginWebServices{
static Dio? dio;
 static init(){//https://student.valuxapps.com/api/
   dio=Dio(
     BaseOptions(
       baseUrl: 'https://student.valuxapps.com/api/',
     receiveDataWhenStatusError: true,

     )
   );
 }


static Future<Response> getData({required String url,
  Map<String,dynamic>? query,String lang="en",
 required String token}) async {
  //Future.delayed(const Duration(milliseconds: 500), () => dio.get(url,queryParameters: query));

  dio?.options.headers= {
    "Content-Type":"application/json",
    "lang": lang,
   "Authorization":token,
  };
  return await dio!.get(url,queryParameters: query);


}

static Future<Response> postData({required String url,
  Map<String,dynamic>? query,
  required Map<String,dynamic> data,
String lang="en",
 required String token}) async {
  //Future.delayed(const Duration(milliseconds: 500), () => dio.get(url,queryParameters: query));
  dio?.options.headers={
    "Content-Type":"application/json",
    "lang":lang,
  "Authorization":token,
  };
  return await dio!.post(url,queryParameters: query,data: data);


}
static Future<Response> putData({required String url,
  Map<String,dynamic>? query,
  required Map<String,dynamic> data,
  String lang="ar",
  required String token}) async {
  //Future.delayed(const Duration(milliseconds: 500), () => dio.get(url,queryParameters: query));
  dio?.options.headers={
    "Content-Type":"application/json",
    "lang":lang,
    "Authorization":token,
  };
  return await dio!.put(url,queryParameters: query,data: data);


}
}
