import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' as getx;
import 'package:byaz_track/core/config/environment_helper.dart';
import 'package:byaz_track/core/dio_provider/api_error.dart';
import 'package:byaz_track/core/dio_provider/api_response.dart';
import 'package:byaz_track/core/preferences/shared_pref.dart';
import 'package:byaz_track/core/routes/app_routes.dart';
import 'package:byaz_track/utlis/app_widget_key.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

export 'package:dio/dio.dart';

Map<String, dynamic> getQuery({int? pageKey, String? searchText}) {
  return searchText != null
      ? {'page': pageKey ?? 1, 'keyword': searchText}
      : {'page': pageKey ?? 1};
}

class DioApiClient {
  DioApiClient(this._dio, this._environmentHelper, this._preference) {
    var baseUrl = _environmentHelper.getValue(EnvironmentKey.baseUrl) ?? '';
    _configureDio(_dio, baseUrl, _preference);
  }

  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  final Dio _dio;
  final EnvironmentHelper _environmentHelper;
  final AppSharedPref _preference;

  void _configureDio(Dio dio, String baseUrl, AppSharedPref preference) {
    dio
      ..options = BaseOptions(
        baseUrl: baseUrl,
        headers: {'Accept': 'application/json'},
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      )
      ..interceptors.addAll([
        AppInterceptor(preference, baseUrl),
        PrettyDioLogger(requestBody: true, requestHeader: true),
      ]);
  }

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken, // Add CancelToken as a parameter
  }) async {
    return _request(
      () => _dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> search(
    String url, {
    Map<String, dynamic>? queryParameters,
    String? searchText,
    CancelToken? cancelToken, // Add CancelToken as a parameter
  }) async {
    return _request(
      () => _dio.get(
        url,
        queryParameters: {'keyword': searchText},
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    CancelToken? cancelToken, // Add CancelToken as a parameter
  }) async {
    return _request(
      () => _dio.post(
        url,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    CancelToken? cancelToken, // Add CancelToken as a parameter
  }) async {
    return _request(
      () => _dio.put(
        url,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    CancelToken? cancelToken, // Add CancelToken as a parameter
  }) async {
    return _request(
      () => _dio.delete(
        url,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> patch(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    CancelToken? cancelToken, // Add CancelToken as a parameter
  }) async {
    return _request(
      () => _dio.patch(
        url,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> _request(
    Future<dynamic> Function() requestFunction,
  ) async {
    if (AppInterceptor.isUnauthorized) {
      throw ApiErrorResponse(message: 'Skipped due to 401 error.');
    }
    try {
      final response = await requestFunction();
      return response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : {'data': response.data};
    } catch (e) {
      _handleRequestError(e);
      rethrow;
    }
  }

  void _handleRequestError(dynamic error) {
    debugPrint(error.toString());

    if (error is SocketException) {
      print('socket exception');
      _handleSocketException(error);
    } else if (error is DioException) {
      print('dio exception');
      _handleDioException(error);
    } else {
      throw error;
    }
  }

  void _handleSocketException(SocketException error) {
    final recoverableErrorCodes = [61, 60, 111, 101, 104, 51, 8, 113, 7, 64];
    if (recoverableErrorCodes.contains(error.osError?.errorCode)) {
      throw ApiConnectionRefusedError(error);
    }
  }

  void _handleDioException(DioException error) {
    if (error.type == DioExceptionType.unknown ||
        error.type == DioExceptionType.badResponse) {
      // if (error.response?.statusCode == 500) {
      //   throw ApiErrorResponse(
      //     message: 'Internal server error. Please try again after sometime.',
      //   );
      // }
      if (error.response?.data is Map &&
          error.response?.data.containsKey('message')) {
        if (error.response?.data['message'] is Map<String, dynamic>) {
          final errors =
              error.response?.data['message'] as Map<String, dynamic>?;
          final firstError = errors?.values.firstOrNull?[0];
          if (firstError != null) {
            throw ApiErrorResponse(message: firstError);
          }
        }
        final errorMsg = error.response?.data['message'] as String?;
        if (errorMsg != null) {
          throw ApiErrorResponse(message: errorMsg);
        }
      } else {
        throw ApiErrorResponse(message: DioErrorHandler.handle(error));
      }
    }
    var msg = DioErrorHandler.handle(error);
    if (error.type == DioExceptionType.cancel) {
      throw ApiErrorResponse(message: msg);
    }
    throw ApiErrorResponse(message: msg);
  }
}

class AppInterceptor extends Interceptor {
  AppInterceptor(this._preference, this.baseUrl);

  final AppSharedPref _preference;
  final String baseUrl;

  static bool isUnauthorized = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      if (isUnauthorized) {
        // Skip requests if 401 was encountered
        handler.reject(
          DioException(
            requestOptions: options,
            error: 'Skipped due to 401 error.',
          ),
        );
        return;
      }
      // final requiresAuth = !_noAuthEndpoints.any(
      //   (endpoint) => options.path.contains(endpoint),
      // );

      // if (requiresAuth) {
      final accessToken = await _preference.getRefreshToken();
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      // }

      options.baseUrl = baseUrl;

      debugPrint('Request: ${options.method} ${options.uri}');
      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to retrieve token',
        ),
      );
    }
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint('Response: ${response.statusCode} ${response.data}');
    if (!_isSuccessStatusCode(response.statusCode)) {
      throw ApiError(response);
    }
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      isUnauthorized = true;
      await _preference.removeAll();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // if (getx.Get.currentRoute != AppRoutes.loginPage) {
        //   try {
        //     getx.Get.find<AppSharedPref>().removeAll();
        //     AppWidgetKey.bottomBarController.jumpToTab(0);
        //     getx.Get.offAllNamed(AppRoutes.loginPage);
        //   } catch (e) {
        //     debugPrint('Navigation failed: $e');
        //   }
        // }
      });
    }

    debugPrint('Error: ${err.message}');
    handler.next(err);
  }

  bool _isSuccessStatusCode(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }
}

void resetUnauthorizedFlag() {
  AppInterceptor.isUnauthorized = false;
}
