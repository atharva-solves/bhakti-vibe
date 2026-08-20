import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:bhakti_vibe/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          responseType: ResponseType.json,
        ),
      ) {
    debugPrint("DioClient initialized with Base URL: ${ApiEndpoints.baseUrl}");
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      debugPrint("Starting GET request to endpoint: $endpoint");
      if (queryParameters != null) {
        debugPrint("With query parameters: $queryParameters");
      }

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      debugPrint("API hit successful! Status code: ${response.statusCode}");

      var responseData = response.data;

      if (responseData is String) {
        debugPrint("Response data is a String, converting to JSON...");
        responseData = jsonDecode(responseData);
      }

      debugPrint("Returning data from DioClient.");
      return responseData;
    } catch (e) {
      debugPrint("Oops! Error in GET request to $endpoint: $e");
      rethrow;
    }
  }
}
