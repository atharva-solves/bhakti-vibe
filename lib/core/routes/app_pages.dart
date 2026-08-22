import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_list_binding.dart';
import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_main_binding.dart';
import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_player_binding.dart';
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_list_by_fest_view.dart.dart';
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_main_view.dart';
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_player_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.aartiMain,
      page: () => AartiMainView(),
      binding: AartiMainBinding(),
    ),
    GetPage(
      name: AppRoutes.aartiPlayer,
      page: () => AartiPlayerView(),
      binding: AartiPlayerBinding(),
    ),
    GetPage(
      name: AppRoutes.aartiListByFest,
      page: () => AartiListByFestView(),
      binding: AartiListByFestBinding(),
    ),
  ];
}
