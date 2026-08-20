import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/aarti_list_by_festival_usecase.dart';
import 'package:get/state_manager.dart';

class AartiListController extends GetxController {
  final AartiListByFestivalUsecase _aartiListByFestivalUsecase;

  AartiListController({
    required AartiListByFestivalUsecase aartiListByFestivalUsecase,
  }) : _aartiListByFestivalUsecase = aartiListByFestivalUsecase;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<AartiEntity> aartisByFestival = <AartiEntity>[].obs;

  Future<void> getAartiListByFestival({required String festivalId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<AartiEntity> aartiListByFestival =
          await _aartiListByFestivalUsecase(festivalId: festivalId);
      aartisByFestival.assignAll(aartiListByFestival);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
