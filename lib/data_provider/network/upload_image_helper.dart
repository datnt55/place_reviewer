
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:place_reviewer/data_provider/network/response_error.dart';

import '../../domain/repository/preference/preference_repository.dart';

import '../../utilities/constants.dart';
import 'end_point.dart';
import 'network_exception.dart';

@singleton
class UploadImageClient {
  @lazySingleton
  Dio get _dio => Dio(
    BaseOptions(
      baseUrl: Endpoints.uploadImageBaseUrl,
      connectTimeout: const Duration(milliseconds: Constants.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: Constants.connectionTimeout),
    ),
    // );
  );

  Future<Map<String, dynamic>> headers(Map<String, dynamic> options) async {
    final Map<String, dynamic> headers = {};
    try {
      headers.addAll({"Authorization": "Bearer public_FW25bE16A6kdLApNeV9sU2RxB5Eu",});
      headers.addAll(options);
    } catch (e) {
      print(e);
    }
    return headers;
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
      String uri, {
        // ignore: type_annotate_public_apis
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress
      }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          responseType: ResponseType.json,
          headers: await headers(options?.headers ?? {}),
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }
}
