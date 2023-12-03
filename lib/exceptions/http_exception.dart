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

  HttpException(this.statusCode, this.message);

  factory HttpException.fromDioException(DioException e) {
    final statusCode = e.response!.statusCode;
    final message = e.response?.statusMessage ?? e.message;

    if (statusCode == HttpStatus.found) {
      return HttpException(StatusCode.found, message);
    } else if (statusCode == HttpStatus.unprocessableEntity) {
      return HttpException(StatusCode.unprocessableEntity, message);
    } else if (statusCode == HttpStatus.internalServerError) {
      return HttpException(StatusCode.internalServerError, message);
    } else {
      return HttpException(StatusCode.unknown, message);
    }
  }
}

enum StatusCode {
  found,
  unprocessableEntity,
  internalServerError,
  unknown,
}
