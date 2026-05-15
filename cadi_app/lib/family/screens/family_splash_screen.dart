// F0 — 家屬 app 初始畫面 (Figma node 1:60)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';

class FamilySplashScreen extends StatefulWidget {
  const FamilySplashScreen({super.key});

  @override
  State<FamilySplashScreen> createState() => _FamilySplashScreenState();
}

class _FamilySplashScreenState extends State<FamilySplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) context.go('/family');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F0FF),
              Color(0xFFF5F0FF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'CADi',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w800,
              color: AppColors.glowBlue,
              letterSpacing: 4,
              shadows: [
                Shadow(
                  color: AppColors.glowBlue.withValues(alpha: 0.5),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
