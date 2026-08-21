import 'package:bhakti_vibe/features/aarti/domain/entities/aarti_entity.dart';

class AartiPlayerArgs {
  final String aartiTitle;
  final String mainImage;
  final String aartiAudio;
  final List<AartiEntity> aartiList;
  final int currentIndex; // We need this to know where we are in the list for next/prev

  AartiPlayerArgs({
    required this.aartiTitle,
    required this.mainImage,
    required this.aartiAudio,
    required this.aartiList,
    required this.currentIndex,
  });
}