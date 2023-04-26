
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:place_reviewer/domain/repository/preference/preference_repository.dart';

import '../../../data_provider/local/cache.dart';
import '../../../data_provider/local/preferences.dart';


@Injectable(as: PreferenceRepository)
class PreferenceRepositoryImp implements PreferenceRepository{
  var cache = GetIt.instance.get<Cache>();
  @override
  Future<String?> getSession() async{
    var sessionValue = await cache.getCache(Preferences.session, '');
    if (sessionValue == '') {
      return null;
    }
    return sessionValue;
  }

  @override
  Future<bool> saveSession(String session) {
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA $session');
    return cache.setCache(Preferences.session, session);
  }
}