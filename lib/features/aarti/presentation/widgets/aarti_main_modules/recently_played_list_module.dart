import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/presentation/args/aarti_player_args.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_main_controller.dart';

class RecentlyPlayedListView extends GetView<AartiMainController> {
  const RecentlyPlayedListView({super.key});

  @override
  Widget build(BuildContext context) {
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
}