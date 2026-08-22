import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Make sure to update this import path to your actual controller file location
import 'package:bhakti_vibe/features/wallpaper/presentation/controllers/wallpaper_full_screen_controller.dart';

class WallpaperFullScreenView extends GetView<WallpaperFullScreenController> {
  const WallpaperFullScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A black background is standard for full-screen images to make colors pop
      backgroundColor: Colors.black,
      
      // This allows the image to stretch all the way to the top of the screen, behind the AppBar
      extendBodyBehindAppBar: true, 
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      
      body: Obx(() {
        // Fallback loading state if the current wallpaper hasn't registered yet
        if (controller.currentWallpaper.value == null) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        // PageView allows standard left/right swiping functionality
        return PageView.builder(
          controller: PageController(initialPage: controller.currentIndex),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.wallpaperList.length,
          onPageChanged: (index) {
            // Trigger your controller logic when the user swipes
            if (index > controller.currentIndex) {
              controller.showNextWallpaper(index);
            } else {
              controller.showPreviousWallpaper(index);
            }
          },
          itemBuilder: (context, index) {
            final wallpaper = controller.wallpaperList[index];

            // InteractiveViewer is a basic widget that adds pinch-to-zoom for free
            return InteractiveViewer(
              child: Image.network(
                wallpaper.images, 
                // BoxFit.contain ensures the whole image fits on screen without cropping the artwork
                fit: BoxFit.contain, 
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white54,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
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