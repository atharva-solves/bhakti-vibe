import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/repositories/wallpaper_repository.dart';

class WallpaperGodCategoriesUsecase {
  final WallpaperRepository _wallpaperRepository;

  WallpaperGodCategoriesUsecase({
    required WallpaperRepository wallpaperRepository,
  }) : _wallpaperRepository = wallpaperRepository;
  Future<List<WallpaperGodCategoryEntity>> call() async {
    final List<WallpaperGodCategoryEntity> wallpGodCatagories =
        await _wallpaperRepository.getWallpaperGodCategories();
    return wallpGodCatagories;
  }
}
