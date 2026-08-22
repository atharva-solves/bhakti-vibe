import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/usecases/wallpaper_god_categories_usecase.dart';
import 'package:get/get.dart';

class WallpaperMainController extends GetxController {
  final WallpaperGodCategoriesUsecase _wallpaperGodCategoriesUsecase;

  WallpaperMainController({
    required WallpaperGodCategoriesUsecase wallpaperGodCategoriesUsecase,
  }) : _wallpaperGodCategoriesUsecase = wallpaperGodCategoriesUsecase;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList wallpGodCategories = <WallpaperGodCategoryEntity>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getWallpGodCategories();
  }

  Future<void> getWallpGodCategories() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<WallpaperGodCategoryEntity> wallpGodCategoryList =
          await _wallpaperGodCategoriesUsecase();
      wallpGodCategories.assignAll(wallpGodCategoryList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
