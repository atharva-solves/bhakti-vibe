import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/festival_category_entity.dart';

abstract class AartiRepository {
  Future<List<FestivalCategoryEntity>> getFestivalCategories();
  Future<List<AartiEntity>> getAartiListByFestival({required String festivalId});
  Future<AartiEntity> getSingleAarti({required String aartiId});

  Future<List<AartiEntity>>getTrendingaAartis();
  Future<List<AartiEntity>>getRecentlyPlayedAartis();
}
