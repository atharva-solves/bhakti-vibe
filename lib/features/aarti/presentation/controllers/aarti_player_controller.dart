import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';
import 'package:bhakti_vibe/features/aarti/presentation/args/aarti_player_args.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart'; 
// import 'path_to/aarti_player_args.dart'; 

class AartiPlayerController extends GetxController {
  

  AartiPlayerController();
      

  // UI State
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Audio Player State
  final AudioPlayer audioPlayer = AudioPlayer(); 
  
  // Track metadata
  final RxString currentTitle = ''.obs;
  final RxString currentImage = ''.obs;
  
  // Progress bar states
  final Rx<Duration> progress = Duration.zero.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;
  final RxBool isPlaying = false.obs;

  // Playlist management
  List<AartiEntity> playlist = [];
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    debugPrint('AartiPlayerController: onInit called');
    
    // Extract args from navigation
    if (Get.arguments is AartiPlayerArgs) {
      final args = Get.arguments as AartiPlayerArgs;
      playlist = args.aartiList;
      currentIndex = args.currentIndex;
      
      debugPrint('AartiPlayerController: Received args. Title: ${args.aartiTitle}, Index: $currentIndex');
      
      currentTitle.value = args.aartiTitle;
      currentImage.value = args.mainImage;
      
      _loadAudio(args.aartiAudio);
    } else {
      debugPrint('AartiPlayerController: No valid arguments received');
    }

    _setupAudioListeners();
  }

  // --- Core Audio Logic ---

  Future<void> _loadAudio(String url) async {
    debugPrint('AartiPlayerController: Attempting to load audio URL: $url');
    try {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      debugPrint('AartiPlayerController: Audio source set successfully, starting playback');
      audioPlayer.play(); 
    } catch (e) {
      debugPrint('AartiPlayerController: Error loading audio -> $e');
      errorMessage.value = "Error loading audio: $e";
    }
  }

  void _setupAudioListeners() {
    debugPrint('AartiPlayerController: Setting up audio stream listeners');
    
    audioPlayer.positionStream.listen((position) {
      progress.value = position;
    });

    audioPlayer.durationStream.listen((duration) {
      totalDuration.value = duration ?? Duration.zero;
    });

    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      
      // Auto-play next track on completion
      if (state.processingState == ProcessingState.completed) {
        debugPrint('AartiPlayerController: Track completed automatically');
        playNext();
      }
    });
  }

  // --- Player Controls ---

  void togglePlayPause() {
    debugPrint('AartiPlayerController: togglePlayPause triggered. Currently playing: ${audioPlayer.playing}');
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void seek(Duration position) {
    debugPrint('AartiPlayerController: Seeking to position: $position');
    audioPlayer.seek(position); 
  }

  void playNext() {
    debugPrint('AartiPlayerController: playNext triggered');
    if (currentIndex < playlist.length - 1) {
      currentIndex++;
      debugPrint('AartiPlayerController: Moving to next index: $currentIndex');
      _updateTrack(playlist[currentIndex]);
    } else {
      debugPrint('AartiPlayerController: Reached end of playlist');
    }
  }

  void playPrevious() {
    debugPrint('AartiPlayerController: playPrevious triggered');
    if (currentIndex > 0) {
      currentIndex--;
      debugPrint('AartiPlayerController: Moving to previous index: $currentIndex');
      _updateTrack(playlist[currentIndex]);
    } else {
      debugPrint('AartiPlayerController: Already at the first track');
    }
  }

  void _updateTrack(AartiEntity nextAarti) {
    debugPrint('AartiPlayerController: Updating track UI to: ${nextAarti.title}');
    currentTitle.value = nextAarti.title;
    currentImage.value = nextAarti.mainImage; 
    
    _loadAudio(nextAarti.audio);
  }

  @override
  void onClose() {
    debugPrint('AartiPlayerController: onClose called, disposing audioPlayer');
    audioPlayer.dispose(); 
    super.onClose();
  }
}