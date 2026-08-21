import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/get_single_aarti_usecase.dart';
import 'package:get/state_manager.dart';

class AartiPlayerController extends GetxController {
  final GetSingleAartiUsecase _getSingleAartiUsecase;

  AartiPlayerController({required GetSingleAartiUsecase getSingleAartiUsecase})
    : _getSingleAartiUsecase = getSingleAartiUsecase;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final singleAarti = Rxn<AartiEntity>();

  final RxList aartis = <AartiEntity>[].obs;

  Future<void> getSingleAarti({required String aartiId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final AartiEntity singleAartiData = await _getSingleAartiUsecase(
        aartiId: aartiId,
      );
      singleAarti.value = singleAartiData;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
