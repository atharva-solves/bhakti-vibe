import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';

class AartiListByFestivalUsecase {
  final AartiRepository _aartiRepository;

  AartiListByFestivalUsecase({required AartiRepository aartiRepository})
    : _aartiRepository = aartiRepository;

  Future<List<AartiEntity>> call({required String festivalId}) async {
    final List<AartiEntity> aartiListByFestival = await _aartiRepository
        .getAartiListByFestival(festivalId: festivalId);
    return aartiListByFestival;
  }
}
