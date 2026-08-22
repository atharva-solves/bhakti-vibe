import 'package:bhakti_vibe/core/network/dio_client.dart';
import 'package:bhakti_vibe/features/aarti/data/data_sources/remote_data_sources/aarti_remote_data_source.dart';
import 'package:bhakti_vibe/features/aarti/data/repository_implementation/aarti_repository_impl.dart';
import 'package:bhakti_vibe/features/aarti/domain/repositories/aarti_repository.dart';
import 'package:bhakti_vibe/features/aarti/domain/usecases/get_single_aarti_usecase.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_player_controller.dart';
import 'package:get/instance_manager.dart';

class AartiPlayerBinding extends Bindings {
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

    Get.lazyPut<GetSingleAartiUsecase>(
      () => GetSingleAartiUsecase(aartiRepository: Get.find<AartiRepository>()),
    );

    Get.lazyPut<AartiPlayerController>(() => AartiPlayerController());
  }
}
