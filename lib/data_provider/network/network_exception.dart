
import 'package:place_reviewer/data_provider/network/response_error.dart';

class NetworkException implements Exception {
  String? message;
  int statusCode;
  ResponseError? response;

  NetworkException({
    required this.message,
    required this.statusCode,
    this.response,
  });
}