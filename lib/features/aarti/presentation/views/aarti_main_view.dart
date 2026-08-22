import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/aarti/presentation/args/aarti_list_by_festival_args.dart';
import 'package:bhakti_vibe/features/aarti/presentation/args/aarti_player_args.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/festival_category_entity.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_main_controller.dart';

class AartiMainView extends GetView<AartiMainController> {
  const AartiMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Matching the warm background color from the design
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

        // SingleChildScrollView allows the whole page to scroll vertically
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.recentlyPlayedAartis.isNotEmpty) ...[
                _buildSectionTitle('Recently Played'),
                _buildRecentlyPlayedList(),
                const SizedBox(height: 24),
              ],

              if (controller.trendingAartis.isNotEmpty) ...[
                _buildSectionTitle("Trending Aarti's"),
                _buildTrendingList(),
                const SizedBox(height: 24),
              ],

              if (controller.festivalCategories.isNotEmpty) ...[
                _buildSectionTitle('Festivals'),
                _buildFestivalList(),
                const SizedBox(height: 32),
              ],
            ],
          ),
        );
      }),
    );
  }

  // --- UI Components ---

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

  Widget _buildRecentlyPlayedList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: controller.recentlyPlayedAartis.length,
        itemBuilder: (context, index) {
          final AartiEntity aarti = controller.recentlyPlayedAartis[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                debugPrint(
                  'Aarti main :recently : on tap: aarti main image ==> ${aarti.mainImage}',
                );
                // Navigate to Player and pass the custom arguments class
                Get.toNamed(
                  AppRoutes.aartiPlayer, // Use your actual route name
                  arguments: AartiPlayerArgs(
                    aartiTitle: aarti.title,
                    mainImage: aarti.mainImage,
                    aartiAudio: aarti.audio,
                    aartiList:
                        controller.recentlyPlayedAartis, // Pass the whole list
                    currentIndex: index, // Pass the tapped index
                  ),
                );
              },
              child: SizedBox(
                width: 110,
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: 110,
                      decoration: BoxDecoration(
                        // Creating the arched/tombstone shape shown in the design
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(60),
                          bottom: Radius.circular(16),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            aarti.withoutBgImage,
                          ), // Uses withoutBgImage
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      aarti.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFA63B3B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: controller.trendingAartis.length,
        itemBuilder: (context, index) {
          final AartiEntity aarti = controller.trendingAartis[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 120,
              child: GestureDetector(
                onTap: () {
                  debugPrint(
                    'Aarti main :trending : on tap: aarti main image ==> ${aarti.mainImage}',
                  );
                  // Navigate to Player and pass the custom arguments class
                  Get.toNamed(
                    AppRoutes.aartiPlayer, // Use your actual route name
                    arguments: AartiPlayerArgs(
                      aartiTitle: aarti.title,
                      mainImage: aarti.mainImage,
                      aartiAudio: aarti.audio,
                      aartiList: controller
                          .recentlyPlayedAartis, // Pass the whole list
                      currentIndex: index, // Pass the tapped index
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // Stack replaced with Container
                      child: Container(
                        alignment:
                            Alignment.bottomLeft, // Aligns child to bottom-left
                        padding: const EdgeInsets.only(
                          left: 8,
                          bottom: 8,
                        ), // Replaces Stack positioning
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(aarti.bgImage), // Uses bgImage
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Play button overlay as a direct child
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Color(0xFFA63B3B),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      aarti.title,
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildFestivalList() {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: controller.festivalCategories.length,
        itemBuilder: (context, index) {
          final FestivalCategoryEntity festivalCategory =
              controller.festivalCategories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 120,
              child: GestureDetector(
                onTap: () {
                  debugPrint(
                    'Aarti main :festival category : on tap:  festival image ==> ${festivalCategory.catImage}',
                  );
                  // Navigate to Player and pass the custom arguments class
                  Get.toNamed(
                    AppRoutes.aartiListByFest, // Use your actual route name
                    arguments: AartiListByFestArgs(
                      festivalCategoryId: festivalCategory.id,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // Stack replaced with Container
                      child: Container(
                        alignment:
                            Alignment.bottomLeft, // Aligns child to bottom-left
                        padding: const EdgeInsets.only(
                          left: 8,
                          bottom: 8,
                        ), // Replaces Stack positioning
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(
                              festivalCategory.catImage,
                            ), // Uses catImage
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Play button overlay as a direct child
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Color(0xFFA63B3B),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      festivalCategory.name,
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
            ),
          );
        },
      ),
    );
  }
}
