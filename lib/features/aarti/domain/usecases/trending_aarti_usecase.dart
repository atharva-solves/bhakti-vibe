import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';

class TrendingAartiUsecase {
  final AartiRepository _aartiRepository;

  TrendingAartiUsecase({required AartiRepository aartiRepository})
    : _aartiRepository = aartiRepository;
  Future<List<AartiEntity>> call() async {
    final List<AartiEntity> trendingAartis = await _aartiRepository
        .getTrendingaAartis();
    return trendingAartis;
  }
}
