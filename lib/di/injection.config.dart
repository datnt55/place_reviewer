// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data_provider/local/cache.dart' as _i3;
import '../data_provider/local/cache_impl.dart' as _i4;
import '../data_provider/network/api/upload_image_api.dart' as _i12;
import '../data_provider/network/http_client_helper.dart' as _i11;
import '../data_provider/network/upload_image_helper.dart' as _i10;
import '../domain/repository/preference/preference_repository.dart' as _i8;
import '../domain/repository/preference/preference_repository_impl.dart' as _i9;
import '../domain/repository/upload/upload_image_repository.dart' as _i13;
import '../domain/repository/upload/upload_image_repository_impl.dart' as _i14;
import '../features/bloc/upload_image_bloc.dart' as _i15;
import '../features/explore/explore_bloc.dart' as _i5;
import '../features/login/login_bloc.dart' as _i6;
import '../navigation_service.dart' as _i7;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.Cache>(_i4.CacheImp());
  gh.factory<_i5.LocationCubit>(() => _i5.LocationCubit());
  gh.factory<_i6.LoginCubit>(() => _i6.LoginCubit());
  gh.singleton<_i7.NavigationService>(_i7.NavigationService());
  gh.factory<_i8.PreferenceRepository>(() => _i9.PreferenceRepositoryImp());
  gh.singleton<_i10.UploadImageClient>(_i10.UploadImageClient());
  gh.singleton<_i11.DioClient>(_i11.DioClient(gh<_i8.PreferenceRepository>()));
  gh.lazySingleton<_i12.UploadImageApi>(
      () => _i12.UploadImageApi(gh<_i10.UploadImageClient>()));
  gh.factory<_i13.UploadImageRepository>(
      () => _i14.UploadImageRepositoryImp(gh<_i12.UploadImageApi>()));
  gh.factory<_i15.UploadImageCubit>(
      () => _i15.UploadImageCubit(gh<_i13.UploadImageRepository>()));
  return getIt;
}
