
import 'package:equatable/equatable.dart';

abstract class ResponseResult<T> {
  const ResponseResult._internal();

  const factory ResponseResult.loading() = LoadingState;
  const factory ResponseResult.success({required T data}) = SuccessState;
  const factory ResponseResult.error({required String exception}) = ErrorState;

  bool get isLoading => this is LoadingState;
  bool get isSuccess => this is SuccessState;
  bool get isError => this is ErrorState;

  T get onSucceed => (this as SuccessState).data;
}

class LoadingState<T> extends ResponseResult<T> with EquatableMixin {
  const LoadingState() : super._internal();

  @override
  String toString() => 'Loading';

  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends ResponseResult<T> with EquatableMixin {
  final T data;
  const SuccessState({required this.data}) : super._internal();

  @override
  String toString() => 'Success';

  @override
  List<Object?> get props => [data];


}

class ErrorState<T> extends ResponseResult<T> with EquatableMixin {
  const ErrorState({required this.exception}): super._internal();

  final String exception;

  @override
  String toString() => 'Error';

  @override
  List<Object?> get props => [exception];
}