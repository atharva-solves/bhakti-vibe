import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/core/routes/app_routes.dart';
import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/presentation/args/aarti_player_args.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_main_controller.dart';

class TrendingListView extends GetView<AartiMainController> {
  const TrendingListView({super.key});

  @override
  Widget build(BuildContext context) {
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
}