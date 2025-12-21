import 'dart:io';

import 'package:dio/dio.dart';
import 'package:byaz_track/core/constants/app_constant.dart';

class ApiError<T extends Response<dynamic>> implements Exception {
  const ApiError(this.response);
  final T? response;
}

class ApiConnectionRefusedError implements Exception {
  const ApiConnectionRefusedError(this.socketException);
  final SocketException socketException;

  @override
  String toString() {
    final address = socketException.address.toString();
    final port = socketException.port.toString();
    return 'ApiConnectionRefusedError: Connection refused on $address and port $port';
  }

  String toHumanReadableMessage() {
    return 'No internet connection.';
  }
}

abstract class AppError implements Exception {
  const AppError({this.message = AppConstants.errorMessage});
  final String message;
  AppError copyWith({String? message}) =>
      InternalAppError(message: message ?? this.message);
}

class InternalAppError extends AppError {
  const InternalAppError({super.message = AppConstants.errorMessage});
}

class DioErrorHandler {
  static String handle(DioException dioError) {
    String errorMessage;

    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage =
            'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request timeout. The server took too long to respond.';
      case DioExceptionType.receiveTimeout:
        errorMessage =
            'Response timeout. The server took too long to send data.';
      case DioExceptionType.unknown:
        if (dioError.response != null) {
          switch (dioError.response?.statusCode) {
            case 401:
              errorMessage =
                  'Unauthorized access. Please check your credentials.';

            case 404:
              errorMessage = 'Server not found. Please try again later.';
            default:
              errorMessage =
                  'Error: ${dioError.response?.statusCode} - ${dioError.response?.statusMessage}';
          }
        } else {
          errorMessage = 'Received invalid response from the server.';
        }

      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled.';
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad Certificate';
      case DioExceptionType.badResponse:
        errorMessage = 'Bad Response';
      case DioExceptionType.connectionError:
        errorMessage = 'Connection Error';
    }

    return errorMessage;
  }
}
