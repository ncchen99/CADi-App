// N1 — 早晨通知 - 錄完影片的鼓勵 (Figma node 1:4)
// 如果昨天有拍影片,隔天會傳送通知 (1:49)
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class TunnelMorningScreen extends StatelessWidget {
  const TunnelMorningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(onTap: () => context.go('/client')),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFFFFE7C8),
                            Color(0xFFFFB78F),
                            Color(0x00FFB78F),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.wb_sunny_rounded,
                            size: 88, color: Colors.white),
                      ),
                    ).animate().fadeIn(duration: 700.ms).scale(
                          begin: const Offset(0.8, 0.8),
                          curve: Curves.easeOutCubic,
                        ),
                    const SizedBox(height: 40),
                    Text(
                      '早安',
                      style: AppTextStyles.displayLarge(context),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 12),
                    Text(
                      '昨天的努力,今天會陪著你',
                      style: AppTextStyles.body(context),
                    ).animate().fadeIn(delay: 500.ms),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 60,
                child: Center(
                  child: CadiPrimaryPill(
                    label: '進入時光隧道',
                    onTap: () => context.push('/client/tunnel/play'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
