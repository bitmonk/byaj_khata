import 'package:flutter/material.dart';
import 'package:byaz_track/core/constants/app_colors.dart';

class CustomScaffold extends StatefulWidget {
  final Widget child;

  const CustomScaffold({super.key, required this.child});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.white, // Top color (e.g., purple)
            AppColors.bottomScaffoldGradient, // Bottom color (e.g., deep blue)
          ],
        ),
      ),
      child: widget.child,
    );
  }
}
