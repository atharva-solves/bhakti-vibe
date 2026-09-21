import 'package:flutter/material.dart';

/// Modular Section Title Widget
class AartiSectionTitleView extends StatelessWidget {
  final String title;

  const AartiSectionTitleView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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