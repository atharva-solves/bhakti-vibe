import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                // Pushes the player controls to the absolute bottom of the screen
                const Spacer(),
                _buildPlayerControls(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
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

  Widget _buildPlayerControls() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Progress Bar ---
          // Wrapping only the progress bar in Obx to handle rapid tick updates efficiently
          Obx(() => ProgressBar(
            progress: controller.progress.value,
            total: controller.totalDuration.value,
            onSeek: (duration) {
              debugPrint('AartiPlayerView: User seeking to $duration');
              controller.seek(duration);
            },
            progressBarColor: const Color(0xFFF7931E),
            baseBarColor: Colors.white.withOpacity(0.2),
            thumbColor: const Color(0xFFF7931E),
            timeLabelTextStyle: const TextStyle(color: Colors.white),
          )),
          const SizedBox(height: 24),
          
          // --- Media Controls ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white, size: 36),
                onPressed: () {
                  debugPrint('AartiPlayerView: Previous track pressed');
                  controller.playPrevious();
                },
              ),
              
              // Main Play/Pause Button
              GestureDetector(
                onTap: () {
                  debugPrint('AartiPlayerView: Play/Pause toggled');
                  controller.togglePlayPause();
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7931E),
                    shape: BoxShape.circle,
                  ),
                  // Localized Obx to just swap the icon state without rebuilding the whole button
                  child: Obx(() => Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  )),
                ),
              ),
              
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white, size: 36),
                onPressed: () {
                  debugPrint('AartiPlayerView: Next track pressed');
                  controller.playNext();
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}