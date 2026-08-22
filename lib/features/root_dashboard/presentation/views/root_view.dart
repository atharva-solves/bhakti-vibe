import 'package:bhakti_vibe/features/root_dashboard/presentation/controllers/root_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Importing  feature views
import 'package:bhakti_vibe/features/aarti/presentation/views/aarti_main_view.dart';
import 'package:bhakti_vibe/features/wallpaper/presentation/views/wallpaper_main_view.dart';

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

        // Simple Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor:
              Colors.white, // Adjust to match Figma's pill container if needed
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.handshake), // Use your specific asset here
              label: 'Aarti',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallpaper), // Use your specific asset here
              label: 'Wallpaper',
            ),
          ],
        ),
      );
    });
  }
}
