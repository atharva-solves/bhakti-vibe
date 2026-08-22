import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/repositories/wallpaper_repository.dart';

class WallpapersByCategoryUsecase {
  final WallpaperRepository _wallpaperRepository;

  WallpapersByCategoryUsecase({
    required WallpaperRepository wallpaperRepository,
  }) : _wallpaperRepository = wallpaperRepository;

  Future<List<WallpaperEntity>?> call({required String godCategoryId}) async {
    final List<WallpaperEntity>? wallpaperPostsByGodCategory =
        await _wallpaperRepository.getWallpaperPostsByGodCategory(
          godCategoryId: godCategoryId,
        );
    return wallpaperPostsByGodCategory;
  }
}
