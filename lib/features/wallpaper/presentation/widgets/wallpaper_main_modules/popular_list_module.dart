import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaper_full_screen_args.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_main_controller.dart';

// new popular list built just like the recently used list
class PopularListView extends GetView<WallpaperMainController> {
  const PopularListView({super.key});

  @override
  Widget build(BuildContext context) {
    // dropped the fixed height 180 wrapper
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemCount: controller.trendingWallpapers.length,
      itemBuilder: (context, index) {
        final WallpaperEntity wallpaper = controller.trendingWallpapers[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.wallpaperFullScreen,
                arguments: WallpaperFullScreenArgs(
                  categoryTitle: 'Popular', 
                  currentWallpaper: wallpaper,
                  currentIndex: index,
                  wallpapers: controller.trendingWallpapers
                      .cast<WallpaperEntity>()
                      .toList(),
                ),
              );
            },
            // setting ratio here too instead of fixed width
            child: AspectRatio(
              aspectRatio: 0.65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                // same simple image setup with no text overlay
                child: Image.network(
                  wallpaper.images,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}