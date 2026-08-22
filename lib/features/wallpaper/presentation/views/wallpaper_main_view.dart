import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/wallpaper/domain/entities/wallpaper_gof_category_entity.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_main_controller.dart';

class WallpaperMainView extends GetView<WallpaperMainController> {
  const WallpaperMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using the same warm background tone as Aarti view for consistency
      backgroundColor: const Color(0xFFFCF4EE),

      body: Obx(() {
        // Show a loader while we fetch the categories
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFA63B3B)),
          );
        }

        // Show a basic error text if the API fails
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Main scrollable area
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We only want to draw this section if the list actually has data
              if (controller.wallpGodCategories.isNotEmpty) ...[
                const SizedBox(
                  height: 16,
                ), // A bit of top padding before the list starts
                _buildSectionHeader(),
                _buildGodCategoriesList(),
              ],
            ],
          ),
        );
      }),
    );
  }

  // Builds the "Gods" title and the "View all" button aligned to opposite ends
  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Gods',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: wire up navigation to the full list view
            },
            child: const Text(
              'View all',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the horizontal scrolling list of round god images
  Widget _buildGodCategoriesList() {
    return SizedBox(
      height:
          110, // Hardcoded height so the circles and text fit nicely without overflowing
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
                // TODO: handle category tap
              },
              child: Column(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Change .image here to whatever your image URL property is named in the entity
                      image: DecorationImage(
                        image: NetworkImage(category.catImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // Change .name here to whatever your text property is named in the entity
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
}
