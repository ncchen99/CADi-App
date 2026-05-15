// C0 — 最初始業面 (Figma node 1:20)
// 一開始進去 app 的畫面 (1:27)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class OnboardingIntroScreen extends StatelessWidget {
  const OnboardingIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.go('/client/onboarding'),
        child: ClientGradientBackground(
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CadiWordmark(size: 64),
                      const SizedBox(height: 24),
                      Text(
                        '陪你走過每一段路',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading2(context).copyWith(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 60,
                  child: Center(
                    child: Text(
                      '輕點任意處開始',
                      style: AppTextStyles.caption(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
