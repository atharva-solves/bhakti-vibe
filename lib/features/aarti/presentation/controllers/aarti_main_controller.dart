import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/festival_category_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/aarti_festival_catagories_usecase.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/recently_played_aarti_usecase.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/trending_aarti_usecase.dart';
import 'package:get/get.dart';

class AartiMainController extends GetxController {
  final AartiFestivalCatagoriesUsecase _aartiFestivalCatagoriesUsecase;
  final TrendingAartiUsecase _trendingAartiUsecase;
  final RecentlyPlayedAartiUsecase _recentlyPlayedAartiUsecase;

  AartiMainController({
    required AartiFestivalCatagoriesUsecase aartiFestivalCatagoriesUsecase,
    required TrendingAartiUsecase trendingAartiUsecase,
    required RecentlyPlayedAartiUsecase recentlyPlayedAartiUsecase,
  }) : _aartiFestivalCatagoriesUsecase = aartiFestivalCatagoriesUsecase,
       _trendingAartiUsecase = trendingAartiUsecase,
       _recentlyPlayedAartiUsecase = recentlyPlayedAartiUsecase;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<FestivalCategoryEntity> festivalCategories =
      <FestivalCategoryEntity>[].obs;

  RxList<AartiEntity> trendingAartis = <AartiEntity>[].obs;

  RxList<AartiEntity> recentlyPlayedAartis = <AartiEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRecentlyPlayedAartis();
    getTrendingAartis();
    getFestivlCategories();
  }

  Future<void> getFestivlCategories() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<FestivalCategoryEntity> festivalCategoryList =
          await _aartiFestivalCatagoriesUsecase();
      festivalCategories.assignAll(festivalCategoryList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTrendingAartis() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<AartiEntity> trendingAartiList = await _trendingAartiUsecase();
      trendingAartis.assignAll(trendingAartiList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getRecentlyPlayedAartis() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<AartiEntity> recentlyPlayedAartiList =
          await _recentlyPlayedAartiUsecase();
      recentlyPlayedAartis.assignAll(recentlyPlayedAartiList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
