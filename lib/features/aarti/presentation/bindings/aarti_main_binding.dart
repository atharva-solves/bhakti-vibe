import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/aarti/data/data_sources/remote_data_sources/aarti_remote_data_source.dart';
import 'package:bhakti_vibe/features/aarti/data/repository_implementation/aarti_repository_impl.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/aarti_festival_catagories_usecase.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/recently_played_aarti_usecase.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/trending_aarti_usecase.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_main_controller.dart';
import 'package:get/instance_manager.dart';

class AartiMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AartiRemoteDataSource>(
      () => AartiRemoteDataSourceImpl(dioClient: Get.find<DioClient>()),
    );
    Get.lazyPut<AartiRepository>(
      () => AartiRepositoryImpl(
        aartiRemoteDataSource: Get.find<AartiRemoteDataSource>(),
      ),
    );
    Get.lazyPut<AartiFestivalCatagoriesUsecase>(
      () => AartiFestivalCatagoriesUsecase(
        aartiRepo: Get.find<AartiRepository>(),
      ),
    );

    Get.lazyPut<TrendingAartiUsecase>(
      () => TrendingAartiUsecase(aartiRepository: Get.find<AartiRepository>()),
    );
    Get.lazyPut<RecentlyPlayedAartiUsecase>(
      () => RecentlyPlayedAartiUsecase(
        aartiRepository: Get.find<AartiRepository>(),
      ),
    );
    Get.lazyPut<AartiMainController>(
      () => AartiMainController(
        aartiFestivalCatagoriesUsecase:
            Get.find<AartiFestivalCatagoriesUsecase>(),
        trendingAartiUsecase: Get.find<TrendingAartiUsecase>(),
        recentlyPlayedAartiUsecase: Get.find<RecentlyPlayedAartiUsecase>(),
      ),
    );
  }
}
