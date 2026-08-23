import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/usecases/recently_used_wallpaper_usecase.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/usecases/trending_wallpapers_usecase.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/usecases/wallpaper_god_categories_usecase.dart';
import 'package:get/get.dart';

class WallpaperMainController extends GetxController {
  final WallpaperGodCategoriesUsecase _wallpaperGodCategoriesUsecase;
  final RecentlyUsedWallpaperUsecase _recentlyUsedWallpaperUsecase;
  final TrendingWallpapersUsecase _trendingWallpapersUsecase;

  WallpaperMainController({
    required WallpaperGodCategoriesUsecase wallpaperGodCategoriesUsecase,
    required RecentlyUsedWallpaperUsecase recentlyUsedWallpaperUsecase,
    required TrendingWallpapersUsecase trendingWallpapersUsecase,
  }) : _trendingWallpapersUsecase = trendingWallpapersUsecase,
       _recentlyUsedWallpaperUsecase = recentlyUsedWallpaperUsecase,
       _wallpaperGodCategoriesUsecase = wallpaperGodCategoriesUsecase;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList wallpGodCategories = <WallpaperGodCategoryEntity>[].obs;
  final RxList recentlyUsedWllpapers = <WallpaperEntity>[].obs;
  final RxList trendingWallpapers = <WallpaperEntity>[].obs;

  @override
  void onInit() {
    super.onInit();

    getWallpGodCategories();
    getRecentlyUsedWallpapers();
    getTrendinWallpapers();
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

  Future<void> getRecentlyUsedWallpapers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<WallpaperEntity> recentWallp =
          await _recentlyUsedWallpaperUsecase();
      if (recentWallp.isNotEmpty) {
        recentlyUsedWllpapers.assignAll(recentWallp);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTrendinWallpapers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<WallpaperEntity> trendingWallp =
          await _trendingWallpapersUsecase();
      if (trendingWallp.isNotEmpty) {
        trendingWallpapers.assignAll(trendingWallp);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
