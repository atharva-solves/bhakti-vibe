import 'package:bhakti_vibe/core/network/api_endpoints.dart';
import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/wallpaper/data/data_models/wallpaper_god_category_model.dart';
import 'package:bhakti_vibe/features/wallpaper/data/data_models/wallpaper_model.dart';

abstract class WallpaperRemoteDataSource {
  Future<List<WallpaperGodCategoryModel>> getWallpaperGodCategoryModels();
  Future<List<WallpaperModel>?> getWallpaperModelsByGodCategory({
    required String godCategoryId,
  });
}

class WallpaperRemoteDataSourceImpl implements WallpaperRemoteDataSource {
  final DioClient _dioClient;

  WallpaperRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;
  @override
  Future<List<WallpaperGodCategoryModel>>
  getWallpaperGodCategoryModels() async {
    try {
      final responseData = await _dioClient.get(
        endpoint: ApiEndpoints.wallpaperCategories,
      );

      final List<dynamic> jsonList = responseData['data'] as List<dynamic>;
      final List<WallpaperGodCategoryModel> wallpaperGodCategoryModels =
          jsonList.map((json) {
            return WallpaperGodCategoryModel.fromJson(json: json);
          }).toList();

      return wallpaperGodCategoryModels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WallpaperModel>?> getWallpaperModelsByGodCategory({
    required String godCategoryId,
  }) async {
    try {
      final response = await _dioClient.get(
        endpoint: ApiEndpoints.wallpaperPosts,
        queryParameters: {'category_id': godCategoryId},
      );
      if (response is List && response[0] is String) {
        return null;
      }

      final List<dynamic> jsonList = response as List<dynamic>;
      final List<WallpaperModel> wallpaperPostsByGodCategory = jsonList
          .map((json) => WallpaperModel.fromGodCategoryJson(json: json))
          .toList();
      return wallpaperPostsByGodCategory;
    } catch (e) {
      rethrow;
    }
  }
}
