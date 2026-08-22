import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_full_screen_controller.dart';
import 'package:get/instance_manager.dart';

class WallpaperFullScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WallpaperFullScreenController>(
      () => WallpaperFullScreenController(),
    );
  }
}
