import 'package:injectable/injectable.dart';

import 'cache_impl.dart';

abstract class Cache{
  Future<bool> setCache(String key, dynamic value);

  Future<dynamic> getCache(String key, dynamic defaultValue);

  @factoryMethod
  static Cache create() {
    return CacheImp();
  }
}