import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;
  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  // static Future<bool?> putBool({required String key,required bool value})async{
  //  return sharedPreferences?.setBool('isDark', value);
  // }
  // static bool? getBool({required String key }){
  //   return sharedPreferences?.getBool('isDark' );
  // }
static Future<bool?> saveData({required String key,required dynamic value})async{
    if(value is String) return sharedPreferences?.setString(key,value );
    if(value is int) return sharedPreferences?.setInt(key,value );
    if(value is bool) return sharedPreferences?.setBool(key,value );
    return sharedPreferences?.setDouble(key,value );
}

  static dynamic getData({required String key }){
    return sharedPreferences?.get(key);
  }
  static Future<bool?> removeData({required String key })async{
      return sharedPreferences?.remove(key);
     }
}