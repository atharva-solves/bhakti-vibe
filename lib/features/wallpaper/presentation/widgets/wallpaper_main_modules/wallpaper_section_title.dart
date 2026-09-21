import 'package:flutter/material.dart';

/// Modular simple title widget
class WallpaperSectionTitleView extends StatelessWidget {
  final String title;

  const WallpaperSectionTitleView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // simple title widget, keeping it clean without the view all button
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
}