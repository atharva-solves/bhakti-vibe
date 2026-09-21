import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhakti_vibe/features/aarti/presentation/controllers/aarti_player_controller.dart';

class AartiPlayerControlsView extends GetView<AartiPlayerController> {
  const AartiPlayerControlsView({super.key});

  @override
  Widget build(BuildContext context) {
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