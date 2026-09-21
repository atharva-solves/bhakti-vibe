import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaper_full_screen_args.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_main_controller.dart';

// modified recently used list to remove the text overlay at the bottom
class RecentlyUsedListView extends GetView<WallpaperMainController> {
  const RecentlyUsedListView({super.key});

  @override
  Widget build(BuildContext context) {
    // dropped the fixed height 180 wrapper
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemCount: controller.recentlyUsedWllpapers.length,
      itemBuilder: (context, index) {
        final WallpaperEntity wallpaper =
            controller.recentlyUsedWllpapers[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.wallpaperFullScreen,
                arguments: WallpaperFullScreenArgs(
                  categoryTitle: 'Recent', // passing title because arguments class needs it
                  currentWallpaper: wallpaper,
                  currentIndex: index,
                  wallpapers: controller.recentlyUsedWllpapers
                      .cast<WallpaperEntity>()
                      .toList(),
                ),
              );
            },
            // removed the fixed width 100 and added an AspectRatio of 0.65 so these tall portrait images don't stretch
            child: AspectRatio(
              aspectRatio: 0.65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                // removed the stack, just showing a plain image now
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