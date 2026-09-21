import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_player_controller.dart';

class AartiPlayerHeaderView extends GetView<AartiPlayerController> {
  const AartiPlayerHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              debugPrint('AartiPlayerView: Back button pressed');
              Get.back();
            },
          ),
          Expanded(
            // Localized Obx so only the text rebuilds when the title changes, avoiding full UI redraws
            child: Obx(() => Text(
              controller.currentTitle.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          // Dummy spacer to balance out the back button and keep the title perfectly centered
          const SizedBox(width: 48), 
        ],
      ),
    );
  }
}