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
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.festivalCategoryList,
      );
      List<Map<String, dynamic>> jsonList =
          responseData as List<Map<String, dynamic>>;
      List<FestivalCategoryDataModel> festivalCategories = jsonList
          .map((json) => FestivalCategoryDataModel.fromJson(json: json))
          .toList();
      return festivalCategories;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AartiDataModel>> getAartiListByFestival({
    required String festivalId,
  }) async {
    try {
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.aartiListByFestival,
        queryParameters: {'id': festivalId},
      );

      final List<Map<String, dynamic>> jsonList =
          responseData as List<Map<String, dynamic>>;
      final List<AartiDataModel> aartiListByFestival = jsonList
          .map((json) => AartiDataModel.fromJson(json: json))
          .toList();
      return aartiListByFestival;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AartiDataModel>> getRecentlyPlayedAartis() async {
    try {
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.recentlyPlayedAarti,
      );

      final List<Map<String, dynamic>> jsonList =
          responseData as List<Map<String, dynamic>>;
      final List<AartiDataModel> recentlyPlayedAartis = jsonList
          .map((json) => AartiDataModel.fromJson(json: json))
          .toList();
      return recentlyPlayedAartis;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AartiDataModel>> getTrendingaAartis() async {
    try {
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.trendingAarti,
      );

      final List<Map<String, dynamic>> jsonList =
          responseData as List<Map<String, dynamic>>;
      final List<AartiDataModel> trendingAartis = jsonList
          .map((json) => AartiDataModel.fromJson(json: json))
          .toList();
      return trendingAartis;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AartiDataModel> getSingleAarti({required String aartiId}) async {
    try {
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.getSingleAarti,
        queryParameters: {'id': aartiId},
      );

      final Map<String, dynamic> json = responseData as Map<String, dynamic>;
      final AartiDataModel singleAarti = AartiDataModel.fromJson(json: json);
      return singleAarti;
    } catch (e) {
      rethrow;
    }
  }
}
