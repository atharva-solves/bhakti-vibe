import 'package:bhakti_vibe/features/aarti/data/data_sources/remote_data_sources/aarti_remote_data_source.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/festival_category_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';

class AartiRepositoryImpl implements AartiRepository {
  final AartiRemoteDataSource _aartiRemoteDataSource;

  AartiRepositoryImpl({required AartiRemoteDataSource aartiRemoteDataSource})
    : _aartiRemoteDataSource = aartiRemoteDataSource;
  @override
  Future<List<AartiEntity>> getAartiListByFestival({
    required String festivalId,
  }) async {
    try {
      final List<AartiEntity> aartiListByFestival = await _aartiRemoteDataSource
          .getAartiListByFestival(festivalId: festivalId);
      return aartiListByFestival;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FestivalCategoryEntity>> getFestivalCategories() async {
    try {
      final List<FestivalCategoryEntity> festivalCategories =
          await _aartiRemoteDataSource.getFestivalCategories();
      return festivalCategories;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AartiEntity>> getRecentlyPlayedAartis() async {
    try {
      final List<AartiEntity> recentlyPlayedAartis =
          await _aartiRemoteDataSource.getRecentlyPlayedAartis();
      return recentlyPlayedAartis;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AartiEntity> getSingleAarti({required String aartiId}) async {
    try {
      final AartiEntity singleAarti = await _aartiRemoteDataSource
          .getSingleAarti(aartiId: aartiId);
      return singleAarti;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AartiEntity>> getTrendingAartis() async {
    try {
      final List<AartiEntity> trendingAartis = await _aartiRemoteDataSource
          .getTrendingaAartis();
      return trendingAartis;
    } catch (e) {
      rethrow;
    }
  }
}
