import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import '../../../domain/entities/upload_image_response.dart';
import '../../../utilities/network_response_result.dart';
import 'package:http_parser/http_parser.dart';
import '../network_exception.dart';
import '../upload_image_helper.dart';

@lazySingleton
class UploadImageApi{
  final UploadImageClient _client;

  UploadImageApi(this._client);

  Future<ResponseResult<UploadImageResponse>> uploadImage(String path, String fileName) async {
    try {
      var mimeType = lookupMimeType(path) ?? '';
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(path, filename: fileName, contentType: MediaType.parse(mimeType))
      });

      final dynamic response = await _client.post('v2/accounts/FW25bE1/uploads/form_data',data: formData);
      final UploadImageResponse currentSession = UploadImageResponse.fromJson(response);
      return ResponseResult.success(data: currentSession);
    } on NetworkException catch (e){
      return ResponseResult.error(exception: e.message ?? '');
    }
  }
}