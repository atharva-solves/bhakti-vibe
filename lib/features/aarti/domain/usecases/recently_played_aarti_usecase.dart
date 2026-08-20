import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';

class RecentlyPlayedAartiUsecase {
  final AartiRepository _aartiRepository;

  RecentlyPlayedAartiUsecase({required AartiRepository aartiRepository})
    : _aartiRepository = aartiRepository;
  Future<List<AartiEntity>> call() async {
    final List<AartiEntity> recentlyPlayedAartis = await _aartiRepository
        .getRecentlyPlayedAartis();
    return recentlyPlayedAartis;
  }
}
