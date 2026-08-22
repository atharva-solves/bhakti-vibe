import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/wallpaper/data/data_sources/wallpaper_remote_data_sources/wallpaper_remote_data_source.dart';
import 'package:bhakti_vibe/features/wallpaper/data/repository_implementation/wallpaper_repo_impl.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/repositories/wallpaper_repository.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/usecases/wallpaper_god_categories_usecase.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_main_controller.dart';
import 'package:get/instance_manager.dart';

class WallpaperMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WallpaperRemoteDataSource>(
      () => WallpaperRemoteDataSourceImpl(dioClient: Get.find<DioClient>()),
    );
    Get.lazyPut<WallpaperRepository>(
      () => WallpaperRepoImpl(
        wallpaperRemoteDataSource: Get.find<WallpaperRemoteDataSource>(),
      ),
    );
    Get.lazyPut<WallpaperGodCategoriesUsecase>(
      () => WallpaperGodCategoriesUsecase(
        wallpaperRepository: Get.find<WallpaperRepository>(),
      ),
    );

    Get.lazyPut<WallpaperMainController>(
      () => WallpaperMainController(
        wallpaperGodCategoriesUsecase:
            Get.find<WallpaperGodCategoriesUsecase>(),
      ),
    );
  }
}
