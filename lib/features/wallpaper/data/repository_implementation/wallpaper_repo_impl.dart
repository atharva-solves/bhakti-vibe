import 'package:bhakti_vibe/features/wallpaper/data/data_sources/wallpaper_remote_data_sources/wallpaper_remote_data_source.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/repositories/wallpaper_repository.dart';

class WallpaperRepoImpl implements WallpaperRepository {
  final WallpaperRemoteDataSource _wallpaperRemoteDataSource;

  WallpaperRepoImpl({
    required WallpaperRemoteDataSource wallpaperRemoteDataSource,
  }) : _wallpaperRemoteDataSource = wallpaperRemoteDataSource;
  @override
  Future<List<WallpaperGodCategoryEntity>> getWallpaperGodCategories() async {
    final List<WallpaperGodCategoryEntity> wallpaperGodCategories =
        await _wallpaperRemoteDataSource.getWallpaperGodCategoryModels();
    return wallpaperGodCategories;
  }
}
