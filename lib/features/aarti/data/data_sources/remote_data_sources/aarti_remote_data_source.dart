import 'package:flutter/foundation.dart';
import 'package:bhakti_vibe/core/network/api_endpoints.dart';
import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/aarti/data/data_models/aarti_data_model.dart';
import 'package:bhakti_vibe/features/aarti/data/data_models/festival_category_data_model.dart';

abstract class AartiRemoteDataSource {
  Future<List<FestivalCategoryDataModel>> getFestivalCategories();
  Future<List<AartiDataModel>> getAartiListByFestival({
    required String festivalId,
  });
  Future<AartiDataModel> getSingleAarti({required String aartiId});

  Future<List<AartiDataModel>> getTrendingaAartis();
  Future<List<AartiDataModel>> getRecentlyPlayedAartis();
}

class AartiRemoteDataSourceImpl implements AartiRemoteDataSource {
  final DioClient _dioClient;

  AartiRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<List<FestivalCategoryDataModel>> getFestivalCategories() async {
    try {
      debugPrint('AartiRemoteDataSource: Fetching festival categories...');
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.festivalCategoryList,
      );

      Map<String, dynamic> mapresponseWithDataWrapper =
          responseData as Map<String, dynamic>;
      List<dynamic> jsonList =
          mapresponseWithDataWrapper['data'] as List<dynamic>;
      List<FestivalCategoryDataModel> festivalCategories = jsonList
          .map(
            (json) => FestivalCategoryDataModel.fromJson(
              json: json as Map<String, dynamic>,
            ),
          )
          .toList();

      debugPrint(
        'AartiRemoteDataSource: Successfully fetched ${festivalCategories.length} festival categories.',
      );
      return festivalCategories;
    } catch (e) {
      debugPrint('AartiRemoteDataSource: Error in getFestivalCategories - $e');
      rethrow;
    }
  }

  @override
  Future<List<AartiDataModel>> getAartiListByFestival({
    required String festivalId,
  }) async {
    try {
      debugPrint(
        'AartiRemoteDataSource: Fetching Aarti list for festivalId: $festivalId...',
      );
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.aartiListByFestival,
        queryParameters: {'id': festivalId},
      );

      final List<dynamic> jsonList = responseData as List<dynamic>;
      final List<AartiDataModel> aartiListByFestival = jsonList
          .map(
            (json) =>
                AartiDataModel.fromJson(json: json as Map<String, dynamic>),
          )
          .toList();

      debugPrint(
        'AartiRemoteDataSource: Successfully fetched ${aartiListByFestival.length} Aartis for festivalId: $festivalId.',
      );
      return aartiListByFestival;
    } catch (e) {
      debugPrint('AartiRemoteDataSource: Error in getAartiListByFestival - $e');
      rethrow;
    }
  }

  @override
  Future<List<AartiDataModel>> getRecentlyPlayedAartis() async {
    try {
      debugPrint('AartiRemoteDataSource: Fetching recently played Aartis...');
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.recentlyPlayedAarti,
      );

      final List<dynamic> jsonList = responseData as List<dynamic>;
      final List<AartiDataModel> recentlyPlayedAartis = jsonList
          .map(
            (json) =>
                AartiDataModel.fromJson(json: json as Map<String, dynamic>),
          )
          .toList();

      debugPrint(
        'AartiRemoteDataSource: Successfully fetched ${recentlyPlayedAartis.length} recently played Aartis.',
      );
      return recentlyPlayedAartis;
    } catch (e) {
      debugPrint(
        'AartiRemoteDataSource: Error in getRecentlyPlayedAartis - $e',
      );
      rethrow;
    }
  }

  @override
  Future<List<AartiDataModel>> getTrendingaAartis() async {
    try {
      debugPrint('AartiRemoteDataSource: Fetching trending Aartis...');
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.trendingAarti,
      );

      final List<dynamic> jsonList = responseData as List<dynamic>;
      final List<AartiDataModel> trendingAartis = jsonList
          .map(
            (json) =>
                AartiDataModel.fromJson(json: json as Map<String, dynamic>),
          )
          .toList();

      debugPrint(
        'AartiRemoteDataSource: Successfully fetched ${trendingAartis.length} trending Aartis.',
      );
      return trendingAartis;
    } catch (e) {
      debugPrint('AartiRemoteDataSource: Error in getTrendingaAartis - $e');
      rethrow;
    }
  }

  @override
  Future<AartiDataModel> getSingleAarti({required String aartiId}) async {
    try {
      debugPrint(
        'AartiRemoteDataSource: Fetching single Aarti for aartiId: $aartiId...',
      );
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.getSingleAarti,
        queryParameters: {'id': aartiId},
      );

      final Map<String, dynamic> json = responseData as Map<String, dynamic>;
      final AartiDataModel singleAarti = AartiDataModel.fromJson(json: json);

      debugPrint(
        'AartiRemoteDataSource: Successfully fetched single Aarti data for ID: $aartiId.',
      );
      return singleAarti;
    } catch (e) {
      debugPrint('AartiRemoteDataSource: Error in getSingleAarti - $e');
      rethrow;
    }
  }
}
