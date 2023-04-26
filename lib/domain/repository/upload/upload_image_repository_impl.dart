
import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:place_reviewer/data_provider/network/api/upload_image_api.dart';
import 'package:place_reviewer/domain/repository/preference/preference_repository.dart';
import 'package:place_reviewer/domain/repository/upload/upload_image_repository.dart';

import '../../../data_provider/local/cache.dart';
import '../../../data_provider/local/preferences.dart';
import '../../../utilities/network_response_result.dart';
import '../../entities/upload_image_response.dart';


@Injectable(as: UploadImageRepository)
class UploadImageRepositoryImp implements UploadImageRepository{
  final UploadImageApi uploadImageApi;
  UploadImageRepositoryImp(this.uploadImageApi);
  @override
  Future<ResponseResult<UploadImageResponse>> uploadImage(String path, String fileName) async {
    return await uploadImageApi.uploadImage(path, fileName);
  }
}