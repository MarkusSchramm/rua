import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFail<T> extends DataState<T> {
  const DataFail(DioException error) : super(error: error);
}

enum TextFieldError {
  empty, 
  invalid
}