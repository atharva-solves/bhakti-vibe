import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';

class WallpaperFullScreenArgs {
  final String categoryTitle;
  final WallpaperEntity currentWallpaper;
  final int currentIndex;
  final List<WallpaperEntity> wallpapers;

  WallpaperFullScreenArgs({
    required this.categoryTitle,
    required this.currentWallpaper,
    required this.currentIndex,
    required this.wallpapers,
  });
}
