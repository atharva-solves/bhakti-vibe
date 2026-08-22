import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaperPostsByGodCategoryArgs.dart';
// Import the full screen args class
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaper_full_screen_args.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_main_controller.dart';

class WallpaperMainView extends GetView<WallpaperMainController> {
  const WallpaperMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EE),
      body: Obx(() {
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

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gods category section
              if (controller.wallpGodCategories.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSectionTitle('Gods'),
                _buildGodCategoriesList(),
              ],

              // Recently Used wallpapers section
              if (controller.recentlyUsedWllpapers.isNotEmpty) ...[
                const SizedBox(
                  height: 24,
                ), // Give some breathing room between sections
                _buildSectionTitle('Recently Used'),
                _buildRecentlyUsedList(),
              ],

              const SizedBox(height: 24), // Bottom padding
            ],
          ),
        );
      }),
    );
  }

  // Simplified header method that just takes a string and prints it without the "View all" button
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // The existing God Categories horizontal list
  Widget _buildGodCategoriesList() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: controller.wallpGodCategories.length,
        itemBuilder: (context, index) {
          final WallpaperGodCategoryEntity category =
              controller.wallpGodCategories[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.wallpapersByCategory,
                  arguments: WallpapersByCategoryArgs(
                    categoryName: category.catName,
                    id: category.id,
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(category.catImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.catName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA63B3B),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // The new Recently Used horizontal list
  Widget _buildRecentlyUsedList() {
    return SizedBox(
      height: 180, // Fixed height for the wallpaper cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: controller.recentlyUsedWllpapers.length,
        itemBuilder: (context, index) {
          // Cast the item as WallpaperEntity to access its properties safely
          final WallpaperEntity wallpaper =
              controller.recentlyUsedWllpapers[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to full screen view and pass all required arguments
                Get.toNamed(
                  AppRoutes.wallpaperFullScreen,
                  arguments: WallpaperFullScreenArgs(
                    currentWallpaper: wallpaper,
                    currentIndex: index,
                    // We need to convert the RxList to a standard List for the arguments
                    wallpapers: controller.recentlyUsedWllpapers
                        .cast<WallpaperEntity>()
                        .toList(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  12.0,
                ), // Rounded corners like in Figma
                child: SizedBox(
                  width: 120, // Give each card a fixed width
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // The wallpaper image itself
                      Image.network(
                        // Make sure to change 'imageUrl' to the actual variable name in your entity
                        wallpaper.images,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
