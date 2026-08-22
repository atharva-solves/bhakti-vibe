import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/aarti/data/data_sources/remote_data_sources/aarti_remote_data_source.dart';
import 'package:bhakti_vibe/features/aarti/data/repository_implementation/aarti_repository_impl.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/aarti_list_by_festival_usecase.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_list_by_fest_controller.dart';
import 'package:get/instance_manager.dart';

class AartiListByFestBinding extends Bindings {
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

    Get.lazyPut<AartiListByFestivalUsecase>(
      () => AartiListByFestivalUsecase(
        aartiRepository: Get.find<AartiRepository>(),
      ),
    );

    Get.lazyPut<AartiListByfestivalController>(
      () => AartiListByfestivalController(
        aartiListByFestivalUsecase: Get.find<AartiListByFestivalUsecase>(),
      ),
    );
  }
}
