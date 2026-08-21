import 'package:bhakti_vibe/features/aarti/domain/entities/festival_category_entity.dart';

class FestivalCategoryDataModel extends FestivalCategoryEntity {
  FestivalCategoryDataModel({
    required super.id,
    required super.name,
    required super.catImage,
  });

  factory FestivalCategoryDataModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return FestivalCategoryDataModel(
      id: json['id'],
      name: json['name'],
      catImage: json['cat_image']??'',
    );
  }
}
