import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_list_binding.dart';
import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_main_binding.dart';
//import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_main_binding.dart';
import 'package:bhakti_vibe/features/aarti/presentation/bindings/aarti_player_binding.dart';
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_list_by_fest_view.dart.dart';
//import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_main_view.dart';
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_player_view.dart';
import 'package:bhakti_vibe/features/root_dashboard/presentation/bindings/root_binding.dart';
import 'package:bhakti_vibe/features/root_dashboard/presentation/views/root_view.dart';
import 'package:bhakti_vibe/features/splash/presentation/bindings/splash_binding.dart';
import 'package:bhakti_vibe/features/splash/presentation/views/bhakti_vibe_splash_view.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/bindings/wallpaper_full_screen_binding.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/bindings/wallpaper_main_binding.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/bindings/wallpapers_by_category_binding.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/views/wallpaper_full_screen_view.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/views/wallpaper_posts_by_category_view.dart';
//import 'package:bhakti_vibe/features/wallpaper/presentation/bindings/wallpaper_main_binding.dart';
//import 'package:bhakti_vibe/features/wallpaper/presentation/views/wallpaper_main_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.rootDashboard,
      page: () => const RootView(),
      bindings: [RootBinding(), AartiMainBinding(), WallpaperMainBinding()],
    ),

    //changed : we'll not nav to aarti main and wallp main
    //we'll nav to root ()--> which will call aarti/wallp scaffold ()
    /* GetPage(
      name: AppRoutes.aartiMain,
      page: () => const AartiMainView(),
      binding: AartiMainBinding(),
    ), */
    GetPage(
      name: AppRoutes.aartiPlayer,
      page: () => const AartiPlayerView(),
      binding: AartiPlayerBinding(),
    ),
    GetPage(
      name: AppRoutes.aartiListByFest,
      page: () => const AartiListByFestView(),
      binding: AartiListByFestBinding(),
    ),

    /* GetPage(
      name: AppRoutes.wallpaperMain,
      page: () => const WallpaperMainView(),
      binding: WallpaperMainBinding(),
    ), */
    GetPage(
      name: AppRoutes.wallpapersByCategory,
      page: () => const WallpapersByCategoryView(),
      binding: WallpapersByCategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.wallpaperFullScreen,
      page: () => const WallpaperFullScreenView(),
      binding: WallpaperFullScreenBinding(),
    ),
  ];
}
