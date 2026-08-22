import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/wallpaper/data/data_sources/wallpaper_remote_data_sources/wallpaper_remote_data_source.dart';
import 'package:bhakti_vibe/features/wallpaper/data/repository_implementation/wallpaper_repo_impl.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/repositories/wallpaper_repository.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/usecases/wallpaper_posts_by_god_category_usecase.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaperPostsByGodCategoryArgs.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_posts_by_god_category_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class WallpapersByCategoryBinding extends Bindings {
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

    Get.lazyPut<WallpapersByCategoryUsecase>(
      () => WallpapersByCategoryUsecase(
        wallpaperRepository: Get.find<WallpaperRepository>(),
      ),
    );

    Get.lazyPut<WallpapersByCategoryController>(
      () => WallpapersByCategoryController(
        wallpaperPostsByGodCategoryUsecase:
            Get.find<WallpapersByCategoryUsecase>(),
      ),
    );
  }
}
