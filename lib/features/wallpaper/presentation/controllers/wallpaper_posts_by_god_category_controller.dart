import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/usecases/wallpaper_posts_by_god_category_usecase.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaperPostsByGodCategoryArgs.dart';
import 'package:get/get.dart';

class WallpapersByCategoryController extends GetxController {
  final WallpapersByCategoryUsecase _wallpaperPostsByGodCategoryUsecase;

  WallpapersByCategoryController({
    required WallpapersByCategoryUsecase wallpaperPostsByGodCategoryUsecase,
  }) : _wallpaperPostsByGodCategoryUsecase = wallpaperPostsByGodCategoryUsecase;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<WallpaperEntity> wallpapersByCategory = <WallpaperEntity>[].obs;
  final RxString categoryName = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as WallpapersByCategoryArgs;

    getWallpapersByCategory(godCategoryId: args.id);
    categoryName.value = args.categoryName;
  }

  Future<void> getWallpapersByCategory({required String godCategoryId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<WallpaperEntity>? wallpapers =
          await _wallpaperPostsByGodCategoryUsecase(
            godCategoryId: godCategoryId,
          );
      if (wallpapers != null) {
        wallpapersByCategory.assignAll(wallpapers);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
