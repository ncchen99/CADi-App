// N3 — 鼓勵的話 (Figma node 1:22)
// 隧道結束顯示鼓勵語句
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class TunnelQuoteScreen extends StatelessWidget {
  const TunnelQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.go('/client'),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '你已經走過許多坎坷,\n每一步都值得被讚賞。',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading1(context).copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.7,
                      ),
                    ).animate().fadeIn(duration: 900.ms).slideY(begin: 0.1),
                    const SizedBox(height: 40),
                    Text(
                      '輕點繼續',
                      style: AppTextStyles.caption(context),
                    ).animate().fadeIn(delay: 1200.ms),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
