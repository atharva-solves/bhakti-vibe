import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaper_full_screen_args.dart';
import 'package:get/get.dart';

class WallpaperFullScreenController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<WallpaperEntity> wallpaperList = <WallpaperEntity>[].obs;
  final currentWallpaper = Rxn<WallpaperEntity>();
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is WallpaperFullScreenArgs) {
      final WallpaperFullScreenArgs args =
          Get.arguments as WallpaperFullScreenArgs;
      wallpaperList.value = args.wallpapers;
      currentWallpaper.value = wallpaperList[currentIndex];
      currentIndex = args.currentIndex;
    }
  }

  void showNextWallpaper(int currIndex) {
    if (currIndex < wallpaperList.length - 1) {
      currentIndex = currIndex;
      currentWallpaper.value = wallpaperList[currentIndex];
    }
  }

  void showPreviousWallpaper(int currIndex) {
    if (currIndex > 0) {
      currentIndex = currIndex;
      currentWallpaper.value = wallpaperList[currentIndex];
    }
  }
}
