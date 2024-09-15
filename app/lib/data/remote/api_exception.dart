import 'dart:io';

class ApiException implements Exception {
  final String? message;
  final int? code;

  ApiException({this.message, this.code});

  @override
  String toString() {
    return "$message";
  }
}

class TimeoutExceededException extends ApiException {
  static const String _kErrorMessage =
      "The connection has timed out, please try again.";
  TimeoutExceededException() : super(message: _kErrorMessage);
}

class BadRequestException extends ApiException {
  // static const String _kErrorMessage = "Invalid request";
  static const String _kErrorMessage = "Thông tin không hợp lệ!";
  BadRequestException({String? message})
      : super(message: message ?? _kErrorMessage, code: HttpStatus.badRequest);
}

class UnauthorizedException extends ApiException {
  static const String _kErrorMessage = "Access denied";
  UnauthorizedException({String? message})
      : super(
            message: message ?? _kErrorMessage, code: HttpStatus.unauthorized);
}

class ForbiddenException extends ApiException {
  static const String _kErrorMessage = "Forbidden";
  ForbiddenException()
      : super(message: _kErrorMessage, code: HttpStatus.unauthorized);
}

class NotFoundException extends ApiException {
  static const String _kErrorMessage =
      "The requested information could not be found";
  NotFoundException({String? errorMessage})
      : super(
            message: errorMessage ?? _kErrorMessage, code: HttpStatus.notFound);
}

class UserNotFoundException extends ApiException {
  static const String _kErrorMessage = "User Not Found";
  UserNotFoundException({String? errorMessage})
      : super(
            message: errorMessage ?? _kErrorMessage, code: HttpStatus.notFound);
}

class ConflictException extends ApiException {
  static const String _kErrorMessage = "Conflict occurred";
  ConflictException()
      : super(message: _kErrorMessage, code: HttpStatus.conflict);
}

class InternalServerErrorException extends ApiException {
  static const String _kErrorMessage =
      "Unknown error occurred, please try again later.";
  InternalServerErrorException()
      : super(message: _kErrorMessage, code: HttpStatus.internalServerError);
}

class NoInternetConnectionException extends ApiException {
  static const String _kErrorMessage =
      "No internet connection detected, please try again.";
  NoInternetConnectionException() : super(message: _kErrorMessage);
}
