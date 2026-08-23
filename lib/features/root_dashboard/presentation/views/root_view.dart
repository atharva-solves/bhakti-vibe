import 'package:bhakti_vibe/core/constants/app_assets/app_image_assets.dart';
import 'package:bhakti_vibe/features/root_dashboard/presentation/controllers/root_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Importing  feature views
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_main_view.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/views/wallpaper_main_view.dart';
// Make sure to import your AppImageAssets if it's not already globally available
// import 'package:bhakti_vibe/core/constants/app_assets/app_image_assets.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAarti = controller.currentIndex.value == 0;

      return Scaffold(
        backgroundColor: const Color(0xFFFCF4EE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFFA63B3B),
            ),
            onPressed: () {
              // Handle back navigation or exit app
            },
          ),
          title: Text(
            isAarti ? 'Aarti' : 'Wallpaper',
            style: const TextStyle(
              color: Color(0xFFA63B3B),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        // Simple conditional rendering (No IndexedStack)
        body: isAarti ? const AartiMainView() : const WallpaperMainView(),

        // I built a custom floating pill container here. Standard BottomNavBars 
        // make it really hard to get that exact orange border and inner pill shape.
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              // Matching the thin orange border from the design
              border: Border.all(color: const Color(0xFFFF9933), width: 1), 
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- Aarti Tab ---
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeTab(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == 0 
                            ? const Color(0xFFFF9933) 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            controller.currentIndex.value == 0 
                                ? AppImageAssets.preayWhite 
                                : AppImageAssets.prayBlack,
                            height: 20,
                            // Coloring the icon to grey when inactive just to be safe
                            color: controller.currentIndex.value == 0 ? Colors.white : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Aarti',
                            style: TextStyle(
                              color: controller.currentIndex.value == 0 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // --- Wallpaper Tab ---
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeTab(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == 1 
                            ? const Color(0xFFFF9933) 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            controller.currentIndex.value == 1 
                                ? AppImageAssets.wallpIconWhite 
                                : AppImageAssets.wallpIconBlack,
                            height: 20,
                            color: controller.currentIndex.value == 1 ? Colors.white : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Wallpaper',
                            style: TextStyle(
                              color: controller.currentIndex.value == 1 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

               
              ],
            ),
          ),
        ),
      );
    });
  }
}