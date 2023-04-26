import 'package:json_annotation/json_annotation.dart';

part 'response_error.g.dart';

@JsonSerializable()
class ResponseError {
  @JsonKey(
    name: "ErrorCode",
  )
  String? code;
  @JsonKey(
    name: "Message",
  )
  String? message;

  ResponseError({
    this.code,
    this.message,
  });

  factory ResponseError.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ResponseErrorFromJson(json);
}
