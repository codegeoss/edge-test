import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test/services/failure.dart';
import 'package:test/services/global.dart';

class NetworkUtil {
  factory NetworkUtil() => _networkUtil;

  NetworkUtil._internal();

  static final NetworkUtil _networkUtil = NetworkUtil._internal();

  final _logger = Logger();

  Dio _getHttpClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: TestConfig.instance!.values.baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{'Accept': 'application/json'},
        connectTimeout: const Duration(seconds: 60 * 1000),
        receiveTimeout: const Duration(seconds: 60 * 1000),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          return handler.next(e);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true),
      );
    }

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        () => HttpClient()..badCertificateCallback = (_, __, ___) => true;
    return dio;
  }

  Future<Map<String, dynamic>> getReq(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _getHttpClient().get<dynamic>(
        url,
        queryParameters: queryParameters,
      );

      var responseBody = <String, dynamic>{};

      if (response.data is List) {
        responseBody['data'] = response.data;
      }
      if (response.data is Map) {
        responseBody = response.data as Map<String, dynamic>;
      }

      if (responseBody.isEmpty) {
        throw Failure(message: 'An error occurred, please try again later');
      }

      return responseBody;
    } on SocketException catch (_) {
      throw Failure(message: 'No internet connection');
    } on TimeoutException catch (_) {
      throw Failure(message: 'Session timeout');
    } on DioException catch (err) {
      _logger
        ..d('Error: $err')
        ..i('${err.response?.statusCode}')
        ..i('Error: ${err.response?.data}');

      final data = err.response?.data as Map<String, dynamic>;

      switch (err.response!.statusCode) {
        case 400:
        case 401:
        case 404:
        case 409:
          throw Failure(
            message: data['message'].toString(),
            statusCode: err.response?.statusCode,
          );
      }

      if (DioExceptionType.unknown == err.type) {
        _logger
          ..d('Error: $err')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');
        throw Exception('Server error');
      } else if (DioExceptionType.connectionTimeout == err.type) {
        throw const SocketException('No internet connection');
      } else if (DioExceptionType.connectionError == err.type) {
        throw const SocketException('No Internet Connection');
      }
      throw Exception('Server error');
    }
  }

  Future<Map<String, dynamic>> postReq(
    String url, {
    String? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _getHttpClient().post<dynamic>(
        url,
        data: body,
        queryParameters: queryParameters,
      );

      final responseBody = response.data as Map<String, dynamic>;

      Logger().i(responseBody);

      if (responseBody.isEmpty) {
        throw Failure(message: 'An error occurred, please try again later');
      }

      return responseBody;
    } on SocketException catch (_) {
      throw Failure(message: 'No internet connection');
    } on TimeoutException catch (_) {
      throw Failure(message: 'Session timeout');
    } on DioException catch (err) {
      _logger
        ..d('Error: $err')
        ..i('${err.response?.statusCode}')
        ..i('Error: ${err.response?.data}');

      final data = err.response?.data as Map<String, dynamic>;

      switch (err.response!.statusCode) {
        case 400:
        case 401:
        case 404:
        case 409:
        case 422:
          throw Failure(
            message: data['message'].toString(),
            statusCode: err.response?.statusCode,
          );
      }

      if (DioExceptionType.unknown == err.type) {
        _logger
          ..d('Error: $err')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');
        throw Exception('Server error');
      } else if (DioExceptionType.connectionTimeout == err.type) {
        throw const SocketException('No internet connection');
      } else if (DioExceptionType.connectionError == err.type) {
        throw const SocketException('No Internet Connection');
      }
      throw Exception('Server error');
    }
  }

  Future<Map<String, dynamic>> patchReq(String url, {String? body}) async {
    try {
      final headers = <String, String>{
        HttpHeaders.contentTypeHeader: 'application/merge-patch+json',
      };

      final response = await _getHttpClient().patch<dynamic>(
        url,
        data: body,
        options: Options(headers: headers),
      );

      final responseBody = response.data as Map<String, dynamic>;

      Logger().i(responseBody);

      if (responseBody.isEmpty) {
        throw Failure(message: 'An error occurred, please try again later');
      }

      return responseBody;
    } on SocketException catch (_) {
      throw Failure(message: 'No internet connection');
    } on TimeoutException catch (_) {
      throw Failure(message: 'Session timeout');
    } on DioException catch (err) {
      _logger
        ..d('Error: $err')
        ..i('${err.response?.statusCode}')
        ..i('Error: ${err.response?.data}');

      final data = err.response?.data as Map<String, dynamic>;

      switch (err.response!.statusCode) {
        case 401:
        case 404:
        case 409:
        case 422:
          throw Failure(
            message: data['message'].toString(),
            statusCode: err.response?.statusCode,
          );
      }

      if (DioExceptionType.unknown == err.type) {
        _logger
          ..d('Error: $err')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');
        throw Exception('Server error');
      } else if (DioExceptionType.connectionTimeout == err.type) {
        throw const SocketException('No internet connection');
      } else if (DioExceptionType.connectionError == err.type) {
        throw const SocketException('No Internet Connection');
      }
      throw Exception('Server error');
    }
  }

  Future<Map<String, dynamic>> putReq(String url, {String? body}) async {
    try {
      final response = await _getHttpClient().put<dynamic>(url, data: body);

      final responseBody = response.data as Map<String, dynamic>;

      Logger().i(responseBody);

      if (responseBody.isEmpty) {
        throw Failure(message: 'An error occurred, please try again later');
      }

      return responseBody;
    } on SocketException catch (_) {
      throw Failure(message: 'No internet connection');
    } on TimeoutException catch (_) {
      throw Failure(message: 'Session timeout');
    } on DioException catch (err) {
      _logger
        ..d('Error: $err')
        ..i('${err.response?.statusCode}')
        ..i('Error: ${err.response?.data}');

      final data = err.response?.data as Map<String, dynamic>;

      switch (err.response!.statusCode) {
        case 401:
        case 404:
        case 409:
        case 422:
          throw Failure(
            message: data['message'].toString(),
            statusCode: err.response?.statusCode,
          );
      }

      if (DioExceptionType.unknown == err.type) {
        _logger
          ..d('Error: $err')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');
        throw Exception('Server error');
      } else if (DioExceptionType.connectionTimeout == err.type) {
        throw const SocketException('No internet connection');
      } else if (DioExceptionType.connectionError == err.type) {
        throw const SocketException('No Internet Connection');
      }
      throw Exception('Server error');
    }
  }

  Future<Map<String, dynamic>> deleteReq(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _getHttpClient().delete<dynamic>(
        url,
        queryParameters: queryParameters,
      );

      final responseBody = response.data as Map<String, dynamic>;

      if (responseBody.isEmpty) {
        throw Failure(message: 'An error occurred, please try again later');
      }

      return responseBody;
    } on SocketException catch (_) {
      throw Failure(message: 'No internet connection');
    } on TimeoutException catch (_) {
      throw Failure(message: 'Session timeout');
    } on DioException catch (err) {
      _logger
        ..d('Error: $err')
        ..i('${err.response?.statusCode}')
        ..i('Error: ${err.response?.data}');

      final data = err.response?.data as Map<String, dynamic>;

      switch (err.response!.statusCode) {
        case 404:
          throw Failure(
            message: data['message'].toString(),
            statusCode: err.response?.statusCode,
          );
      }

      if (DioExceptionType.unknown == err.type) {
        _logger
          ..d('Error: $err')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');
        throw Exception('Server error');
      } else if (DioExceptionType.connectionTimeout == err.type) {
        throw const SocketException('No internet connection');
      } else if (DioExceptionType.connectionError == err.type) {
        throw const SocketException('No Internet Connection');
      }
      throw Exception('Server error');
    }
  }
}
