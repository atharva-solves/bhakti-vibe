import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';

class AartiDataModel extends AartiEntity {
  AartiDataModel({
    required super.id,
    required super.title,
    required super.withoutBgImage,
    required super.bgImage,
    required super.audio,
    required super.mainImage,
  });
  factory AartiDataModel.fromJson({required Map<String, dynamic> json}) {
    return AartiDataModel(
      id: json['id'] ,
      title: json['title'] ?? 'untitled',
      withoutBgImage: json['without_bg_image']?? '',
      bgImage: json['bg_image']??'',
      audio: json['audio'],
      mainImage: json['mainImage']??'',
    );
  }
}
