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
    return Obx(() {
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

      // Fixed height view: components will dynamically scale via Expanded
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.recentlyPlayedAartis.isNotEmpty) ...[
            _buildSectionTitle('Recently Played'),
            Expanded(child: _buildRecentlyPlayedList()),
            const SizedBox(height: 12),
          ],

          if (controller.trendingAartis.isNotEmpty) ...[
            _buildSectionTitle("Trending Aarti's"),
            Expanded(child: _buildTrendingList()),
            const SizedBox(height: 12),
          ],

          if (controller.festivalCategories.isNotEmpty) ...[
            _buildSectionTitle('Festivals'),
            Expanded(child: _buildFestivalList()),
            const SizedBox(height: 16),
          ],
        ],
      );
    });
  }

  // --- UI Components ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
    return ListView.builder(
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
              Get.toNamed(
                AppRoutes.aartiPlayer,
                arguments: AartiPlayerArgs(
                  aartiTitle: aarti.title,
                  mainImage: aarti.mainImage,
                  aartiAudio: aarti.audio,
                  aartiList: controller.recentlyPlayedAartis,
                  currentIndex: index,
                ),
              );
            },
            child: Column(
              children: [
                // Expanded replaces hardcoded height, AspectRatio dictates width dynamically
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 0.85, // Tombstone shape ratio
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(60),
                          bottom: Radius.circular(16),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/god_cat_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(60),
                          bottom: Radius.circular(16),
                        ),
                        child: Image.network(
                          aarti.withoutBgImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 90, // Limit text width to prevent stretching
                  child: Text(
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrendingList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: controller.trendingAartis.length,
      itemBuilder: (context, index) {
        final AartiEntity aarti = controller.trendingAartis[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.aartiPlayer,
                arguments: AartiPlayerArgs(
                  aartiTitle: aarti.title,
                  mainImage: aarti.mainImage,
                  aartiAudio: aarti.audio,
                  aartiList: controller.recentlyPlayedAartis, 
                  currentIndex: index,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.0, // Square shape from Figma
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(aarti.bgImage),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 90,
                  child: Text(
                    aarti.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA63B3B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFestivalList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: controller.festivalCategories.length,
      itemBuilder: (context, index) {
        final FestivalCategoryEntity festivalCategory =
            controller.festivalCategories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.aartiListByFest,
                arguments: AartiListByFestArgs(
                  festivalCategoryId: festivalCategory.id,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 0.75, // Tall rectangle shape from Figma
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(festivalCategory.catImage),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 90,
                  child: Text(
                    festivalCategory.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA63B3B),
                    ),
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