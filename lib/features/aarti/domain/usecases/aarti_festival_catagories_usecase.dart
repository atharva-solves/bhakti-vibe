import 'package:bhakti_vibe/features/aarti/domain/entities/festival_category_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';

class AartiFestivalCatagoriesUsecase {
  final AartiRepository _aartiRepo;
  AartiFestivalCatagoriesUsecase({required AartiRepository aartiRepo})
    : _aartiRepo = aartiRepo;

  Future<List<FestivalCategoryEntity>> call() async {
    final List<FestivalCategoryEntity> festivalCategories = await _aartiRepo
        .getFestivalCategories();
    return festivalCategories;
  }
}
