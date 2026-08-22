import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_posts_by_god_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_entity.dart';

class WallpapersByCategoryView extends GetView<WallpapersByCategoryController> {
  const WallpapersByCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Maintaining the consistent warm background color
      backgroundColor: const Color(0xFFFCF4EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFA63B3B)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller
              .categoryName
              .value, // Note: You can dynamically pass the God's name here via Get.arguments if you'd like it to match Figma exactly (e.g. 'Gopala')
          style: const TextStyle(
            color: Color(0xFFA63B3B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        // 1. Loading State
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFA63B3B)),
          );
        }

        // 2. Error State
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // 3. Empty State
        if (controller.wallpapersByCategory.isEmpty) {
          return const Center(
            child: Text(
              'No wallpapers found.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          );
        }

        // 4. Success State - Simple Grid View (2 items horizontally)
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items side-by-side
            crossAxisSpacing: 12.0, // Horizontal spacing
            mainAxisSpacing: 12.0, // Vertical spacing
            childAspectRatio:
                0.65, // Makes the items taller than they are wide (like wallpapers)
          ),
          itemCount: controller.wallpapersByCategory.length,
          itemBuilder: (context, index) {
            final WallpaperEntity wallpaper =
                controller.wallpapersByCategory[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                wallpaper.images,
                fit: BoxFit.cover,
                // Optional: Adds a smooth loading effect for network images
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.black12,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFA63B3B),
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
