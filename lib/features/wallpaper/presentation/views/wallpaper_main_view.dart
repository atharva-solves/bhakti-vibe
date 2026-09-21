import 'package:bhakti_vibe/features/wallpaper/presentation/widgets/wallpaper_main_modules/god_category_list.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/widgets/wallpaper_main_modules/popular_list_module.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/widgets/wallpaper_main_modules/recently_used_list_module.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/widgets/wallpaper_main_modules/wallpaper_section_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_main_controller.dart';

class WallpaperMainView extends GetView<WallpaperMainController> {
  const WallpaperMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFFA63B3B)),
        );
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gods category section
          if (controller.wallpGodCategories.isNotEmpty) ...[
            const SizedBox(height: 1),
            const WallpaperSectionTitleView(title: 'Gods'),
            const Expanded(child: GodCategoriesListView()),
          ],
        
          // Recently Used section
          if (controller.recentlyUsedWllpapers.isNotEmpty) ...[
            const SizedBox(height: 09),
            const WallpaperSectionTitleView(title: 'Recent'),
            const Expanded(child: RecentlyUsedListView()),
          ],
        
          // added the popular section here
          // checking if the trending list has items before drawing it on screen
          if (controller.trendingWallpapers.isNotEmpty) ...[
            const SizedBox(height: 09),
            const WallpaperSectionTitleView(title: 'Popular'),
            const Expanded(child: PopularListView()),
          ],
        
          const SizedBox(height: 19),
        ],
      );
    });
  }
}