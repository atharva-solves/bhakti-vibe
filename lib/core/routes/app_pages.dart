import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_main_binding.dart';
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_main_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.aartiMain,
      page: () => AartiMainView(),
      binding: AartiMainBinding(),
    ),
  ];
}
