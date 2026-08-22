import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';

abstract class WallpaperRepository {
   Future<List<WallpaperGodCategoryEntity>> getWallpaperGodCategories();
}