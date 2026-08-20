import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';

class GetSingleAartiUsecase {
  final AartiRepository _aartiRepository;

  GetSingleAartiUsecase({required AartiRepository aartiRepository})
    : _aartiRepository = aartiRepository;
  Future<AartiEntity> call({required String aartiId}) async {
    final AartiEntity singleAarti = await _aartiRepository.getSingleAarti(
      aartiId: aartiId,
    );
    return singleAarti;
  }
}
