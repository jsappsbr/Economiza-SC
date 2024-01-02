import 'dart:io';
import 'package:dio/dio.dart';

class HttpException implements Exception {
  final String? message;
  final int? statusCode;

  bool get isUnauthorized => statusCode == HttpStatus.unauthorized;

  bool get isFound => statusCode == HttpStatus.found;

  bool get isUnprocessableEntity =>
      statusCode == HttpStatus.unprocessableEntity;

  bool get isInternalServerError =>
      statusCode == HttpStatus.internalServerError;

  bool get isUnknown => statusCode == null;

  HttpException(this.statusCode, this.message);

  factory HttpException.fromDioException(DioException e) {
    final statusCode = e.response!.statusCode;
    final message = e.response?.statusMessage ?? e.message;
    return HttpException(statusCode, message);
  }
}