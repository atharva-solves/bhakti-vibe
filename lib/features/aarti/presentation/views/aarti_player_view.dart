import 'package:bhakti_vibe/features/aarti/presentation/widgets/aarti_player_modules.dart/aarti_player_controls.dart';
import 'package:bhakti_vibe/features/aarti/presentation/widgets/aarti_player_modules.dart/aarti_player_header_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_player_controller.dart';

class AartiPlayerView extends GetView<AartiPlayerController> {
  const AartiPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('AartiPlayerView: build() called');

    return Scaffold(
      // Default background color to show before the image fully loads
      backgroundColor: Colors.black,
      
      // Top-level Obx handles background image changes when switching tracks
      body: Obx(() {
        // Guard against empty URLs to prevent NetworkImage from throwing an exception
        final imageUrl = controller.currentImage.value;
        debugPrint('AartiPlayerView: Current background image URL updated -> $imageUrl');

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    // Adding a dark overlay so the white text and controls pop out
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  )
                : null,
          ),
          child: const SafeArea(
            child: Column(
              children: [
                AartiPlayerHeaderView(),
                // Pushes the player controls to the absolute bottom of the screen
                Spacer(),
                AartiPlayerControlsView(),
              ],
            ),
          ),
        );
      }),
    );
  }
}