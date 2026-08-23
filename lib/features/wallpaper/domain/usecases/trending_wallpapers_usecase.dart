import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/repositories/wallpaper_repository.dart';

class TrendingWallpapersUsecase {
  final WallpaperRepository _wallpaperRepository;

  TrendingWallpapersUsecase({required WallpaperRepository wallpaperRepository})
    : _wallpaperRepository = wallpaperRepository;

  Future<List<WallpaperEntity>> call() {
    return _wallpaperRepository.getTrendingWallpapers();
  }
}
