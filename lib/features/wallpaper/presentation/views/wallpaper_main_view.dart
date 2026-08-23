import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaperPostsByGodCategoryArgs.dart';
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
    return  Obx(() {
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
              _buildSectionTitle('Gods'),
              Expanded(child: _buildGodCategoriesList()),
            ],
        
            // Recently Used section
            if (controller.recentlyUsedWllpapers.isNotEmpty) ...[
              const SizedBox(height: 09),
              _buildSectionTitle('Recent'),
              Expanded(child: _buildRecentlyUsedList()),
            ],
        
            // added the popular section here
            // checking if the trending list has items before drawing it on screen
            if (controller.trendingWallpapers.isNotEmpty) ...[
              const SizedBox(height: 09),
              _buildSectionTitle('Popular'),
              Expanded(child: _buildPopularList()),
            ],
        
            const SizedBox(height: 19),
          ],
        );
      });
  }

  // simple title widget, keeping it clean without the view all button
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

  // existing god categories list
  Widget _buildGodCategoriesList() {
    // took out the fixed height box so it flexes with Expanded
    return ListView.builder(
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
                // swapped fixed 72x72 sizing for Expanded + AspectRatio so circles scale down nicely
                // wrapped this in padding to make the circles smaller 
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(category.catImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
    );
  }

  // modified recently used list to remove the text overlay at the bottom
  Widget _buildRecentlyUsedList() {
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

  // new popular list built just like the recently used list
  Widget _buildPopularList() {
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