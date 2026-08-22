import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';

class WallpaperModel extends WallpaperEntity {
  WallpaperModel({required super.id, required super.images});

  factory WallpaperModel.fromGodCategoryJson({required Map<String, dynamic> json}) {
    return WallpaperModel(id: json['id'], images: json['images'] ?? '');
  }

  factory WallpaperModel.fromTrendingJson({required Map<String, dynamic> json}) {
    return WallpaperModel(id: json['id'], images: json['post_image'] ?? '');
  }
}
