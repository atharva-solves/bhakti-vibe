import 'package:bhakti_vibe/core/network/api_endpoints.dart';
import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/wallpaper/data/data_models/wallpaper_god_category_model.dart';

abstract class WallpaperRemoteDataSource {
  Future<List<WallpaperGodCategoryModel>> getWallpaperGodCategoryModels();
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
}
