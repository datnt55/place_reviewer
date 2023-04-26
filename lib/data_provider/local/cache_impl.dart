import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache.dart';

@Singleton(as: Cache)
class CacheImp extends Cache{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Future<bool> setCache(String key, dynamic value) async{
    SharedPreferences prefs = await _prefs;
    var result = false;
    if (value is int){
      result = await prefs.setInt(key, value);
    }else if (value is String){
      result = await prefs.setString(key, value);
    }else if (value is bool){
      result = await prefs.setBool(key, value);
    }else if (value is double){
      result = await prefs.setDouble(key, value);
    }

    return result;
  }

  @override
  Future getCache(String key, defaultValue) async{
    SharedPreferences prefs = await _prefs;
    if (defaultValue is int){
      return prefs.getInt(key)?? defaultValue;
    }else if (defaultValue is String){
      return prefs.getString(key)?? defaultValue;
    }else if (defaultValue is bool){
      return prefs.getBool(key)?? defaultValue;
    }else if (defaultValue is double){
      return prefs.getDouble(key)?? defaultValue;
    }
  }
}