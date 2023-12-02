import 'dart:io';
import 'package:dio/dio.dart';

class HttpException implements Exception {
  final String? message;
  final StatusCode statusCode;

  bool get isFound => statusCode == StatusCode.found;

  bool get isUnprocessableEntity =>
      statusCode == StatusCode.unprocessableEntity;

  bool get isInternalServerError =>
      statusCode == StatusCode.internalServerError;

  bool get isUnknown => statusCode == StatusCode.unknown;

  HttpException(this.message, this.statusCode);

  factory HttpException.fromDioException(DioException e) {
    final statusCode = e.response!.statusCode;
    final message = e.response?.statusMessage ?? e.message;

    if (statusCode == HttpStatus.found) {
      return HttpException(message, StatusCode.found);
    } else if (statusCode == HttpStatus.unprocessableEntity) {
      return HttpException(message, StatusCode.unprocessableEntity);
    } else if (statusCode == HttpStatus.internalServerError) {
      return HttpException(message, StatusCode.internalServerError);
    } else {
      return HttpException(message, StatusCode.unknown);
    }
  }
}

enum StatusCode {
  found,
  unprocessableEntity,
  internalServerError,
  unknown,
}
