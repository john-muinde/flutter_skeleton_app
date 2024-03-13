import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_buddy_app/constants/strings.dart';
import 'package:study_buddy_app/data/token_interceptor.dart';

class DioClient {
  final String baseUrl;
  final TokenInterceptor tokenInterceptor;
  final SharedPreferences sharedPreferences;

  Dio? dio;
  String? token;
  String? countryCode;

  DioClient(
    this.baseUrl,
    Dio? dioC, {
    required this.tokenInterceptor,
    required this.sharedPreferences,
  }) {
    token = sharedPreferences.getString(StringConstants.userLoginToken);
    if (kDebugMode) {
      print("NNNN $token");
    }
    dio = dioC ?? Dio();
    dio
      ?..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(minutes: 3)
      ..options.receiveTimeout = const Duration(minutes: 3)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
    dio!.interceptors.add(tokenInterceptor);
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    List<int> acceptedStatusCodes = const [200],
  }) async {
    try {
      var response = await dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (acceptedStatusCodes.contains(response.statusCode)) {
        return response;
      } else if (response.statusCode == 401) {
        throw ErrorDescription('Unauthorized');
      } else if (jsonDecode(response.data)['message'] != null) {
        throw ErrorDescription(jsonDecode(response.data)['message']);
      } else {
        throw ErrorDescription(
            "Service unavailable. we'll be back soon ${response.statusCode}");
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    List<int> acceptedStatusCodes = const [200],
  }) async {
    try {
      var response = await dio!.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (acceptedStatusCodes.contains(response.statusCode)) {
        return response;
      } else if (response.statusCode == 401) {
        throw ErrorDescription('Unauthorized');
      } else if (jsonDecode(response.data)['message'] != null) {
        throw ErrorDescription(jsonDecode(response.data)['message']);
      } else {
        throw ErrorDescription(
            "Service unavailable. we'll be back soon ${response.statusCode}");
      }
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    List<int> acceptedStatusCodes = const [200],
  }) async {
    try {
      var response = await dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (acceptedStatusCodes.contains(response.statusCode)) {
        return response;
      } else if (response.statusCode == 401) {
        throw ErrorDescription('Unauthorized');
      } else if (jsonDecode(response.data)['message'] != null) {
        throw ErrorDescription(jsonDecode(response.data)['message']);
      } else {
        throw ErrorDescription(
            "Service unavailable. we'll be back soon ${response.statusCode}");
      }
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    List<int> acceptedStatusCodes = const [200],
  }) async {
    try {
      var response = await dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (acceptedStatusCodes.contains(response.statusCode)) {
        return response;
      } else if (response.statusCode == 401) {
        throw ErrorDescription('Unauthorized');
      } else if (jsonDecode(response.data)['message'] != null) {
        throw ErrorDescription(jsonDecode(response.data)['message']);
      } else {
        throw ErrorDescription(
            "Service unavailable. we'll be back soon ${response.statusCode}");
      }
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
