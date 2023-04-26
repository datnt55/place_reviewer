
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
class DioClient {
  final PreferenceRepository preference;

  DioClient(this.preference);

  @lazySingleton
  Dio get _dio => Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(microseconds: Constants.connectionTimeout),
      receiveTimeout: const Duration(microseconds: Constants.connectionTimeout),
    ),
    // );
  );

  Future<Map<String, dynamic>> headers(Map<String, dynamic> options) async {
    print(Endpoints.baseUrl);
    final Map<String, dynamic> headers = {};
    try {
      var token = await preference.getSession();
      if (token != null && token.isNotEmpty) {
        headers.addAll({"Authorization": "Bearer $token",});
      }
      headers.addAll(options);
    } catch (e) {
      print(e);
    }
    return headers;
  }

  // Xử lý chung với hệ thống
  Future<NetworkException> _handleApiError(DioError e) async {
    final response = e.response;
    final int statusCode = response?.statusCode ?? -1;

    if (response == null) {
      if (e.error is SocketException) {
        return NetworkException(
          message: e.message,
          statusCode: statusCode,
        );
      }
      return NetworkException(
        message: e.message,
        statusCode: statusCode,
      );
    }
    final responseData = response.data["ResponseStatus"];
    final responseError = ResponseError.fromJson(responseData);
    if (responseError.code == null) {
      return NetworkException(
        message: e.message,
        statusCode: statusCode,
        response: responseError,
      );
    } else {
      // Nếu đã đăng nhập
      if (statusCode == 401 || statusCode == 405) {
        //TODO : Check neu da dang nhap thi navigate ve login
        return NetworkException(
          message: responseError.message ?? "Có lỗi",
          statusCode: statusCode,
          response: responseError,
        );
      } else {
        return NetworkException(
          message: responseError.message ?? "Có lỗi",
          statusCode: statusCode,
          response: responseError,
        );
      }
    }
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: await headers(options?.headers ?? {}),
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      final exception = await _handleApiError(e);
      throw exception;
    } catch (e) {
      print(e);
      rethrow;
    }
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
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: await headers(options?.headers ?? {}),
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      final exception = await _handleApiError(e);
      throw exception;
    }
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(
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
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: await headers(options?.headers ?? {}),
        ),
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError catch (e) {
      final exception = await _handleApiError(e);
      throw exception;
    }
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(
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
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: await headers(options?.headers ?? {}),
        ),
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError catch (e) {
      final exception = await _handleApiError(e);
      throw exception;
    }
  }
}
