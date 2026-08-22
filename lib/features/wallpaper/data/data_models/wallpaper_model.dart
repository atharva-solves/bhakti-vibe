import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';

class WallpaperModel extends WallpaperEntity {
  WallpaperModel({required super.id, required super.images});

  factory WallpaperModel.fromJson({required Map<String, dynamic> json}) {
    return WallpaperModel(id: json['id'], images: json['images'] ?? '');
  }
}
