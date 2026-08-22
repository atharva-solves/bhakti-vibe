import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/presentation/args/aarti_player_args.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_list_by_fest_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AartiListByFestView extends GetView<AartiListByfestivalController> {
  const AartiListByFestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Matching the warm background color from AartiMainView
      backgroundColor: const Color(0xFFFCF4EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFA63B3B)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Aarti',
          style: TextStyle(
            color: Color(0xFFA63B3B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        // Handle Loading State
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFA63B3B)),
          );
        }

        // Handle Error State
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Handle Empty State
        if (controller.aartisByFestival.isEmpty) {
          return const Center(
            child: Text(
              'No Aartis found.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          );
        }

        // Simple uncluttered list
        return ListView.separated(
          
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          itemCount: controller.aartisByFestival.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final AartiEntity aarti = controller.aartisByFestival[index];
            
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // Navigate to Player and pass the custom arguments class
                Get.toNamed(
                  AppRoutes.aartiPlayer,
                  arguments: AartiPlayerArgs(
                    aartiTitle: aarti.title,
                    mainImage: aarti.mainImage,
                    aartiAudio: aarti.audio,
                    aartiList: controller.aartisByFestival, 
                    currentIndex: index, 
                  ),
                );
              },
              child: Row(
                children: [
                  // Leading Square Image
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(aarti.mainImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Aarti Title (and optional subtitle if your entity supports it)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aarti.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        // Assuming the subtitle from Figma might not be strictly 
                        // available in the entity. If you have a hindi title field, 
                        // you can place it here.
                        const SizedBox(height: 4),
                        const Text(
                          'Aarti', // Simple placeholder to match the 2-line layout
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            );
          },
        );
      }),
    );
  }
}