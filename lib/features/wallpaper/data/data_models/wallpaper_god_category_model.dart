import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';

class WallpaperGodCategoryModel extends WallpaperGodCategoryEntity {
  WallpaperGodCategoryModel({
    required super.id,
    required super.catName,
    required super.catImage,
  });
  factory WallpaperGodCategoryModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return WallpaperGodCategoryModel(
      id: json['id'],
      catName: json['cat_name'] ?? 'untitled',
      catImage: json['cat_image'] ?? '',
    );
  }
}
