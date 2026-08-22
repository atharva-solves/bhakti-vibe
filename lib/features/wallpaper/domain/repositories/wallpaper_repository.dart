import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';

abstract class WallpaperRepository {
  Future<List<WallpaperGodCategoryEntity>> getWallpaperGodCategories();
  Future<List<WallpaperEntity>>? getWallpaperPostsByGodCategory({
    required String godCategoryId,
  });
}
