import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/args/wallpaperPostsByGodCategoryArgs.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_main_controller.dart';

// existing god categories list
class GodCategoriesListView extends GetView<WallpaperMainController> {
  const GodCategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
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
}