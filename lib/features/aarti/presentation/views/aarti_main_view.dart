import 'package:bhakti_vibe/features/aarti/presentation/widgets/aarti_main_modules/aarti_section_title_widget.dart';
import 'package:bhakti_vibe/features/aarti/presentation/widgets/aarti_main_modules/festival_list_module.dart';
import 'package:bhakti_vibe/features/aarti/presentation/widgets/aarti_main_modules/recently_played_list_module.dart';
import 'package:bhakti_vibe/features/aarti/presentation/widgets/aarti_main_modules/trending_list_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            const AartiSectionTitleView(title: 'Recently Played'),
            const Expanded(child: RecentlyPlayedListView()),
            const SizedBox(height: 12),
          ],

          if (controller.trendingAartis.isNotEmpty) ...[
            const AartiSectionTitleView(title: "Trending Aarti's"),
            const Expanded(child: TrendingListView()),
            const SizedBox(height: 12),
          ],

          if (controller.festivalCategories.isNotEmpty) ...[
            const AartiSectionTitleView(title: 'Festivals'),
            const Expanded(child: FestivalListView()),
            const SizedBox(height: 16),
          ],
        ],
      );
    });
  }
}